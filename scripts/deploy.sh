#!/usr/bin/env bash
set -euxo pipefail


BRANCH_DEPLOYING_TO_STAGING=s3
BRANCH_DEPLOYING_TO_PRODUCTION=s3-production

NAME_POSTFIX=
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$CURRENT_BRANCH" == "$BRANCH_DEPLOYING_TO_STAGING" ]]; then
  NAME_POSTFIX=.staging
elif [[ "$CURRENT_BRANCH" == "$BRANCH_DEPLOYING_TO_PRODUCTION" ]]; then
  NAME_POSTFIX=
else
  exit 255
fi


# prepare files
mkdir -p build
node scripts/prepare.js

MIN_JSON=build/Echo.min.json


# only deploy if json has changes besides the updated_at date
function md5_no_upd {
  perl -pe 's|,"updated_at":".+?"||' | md5sum
}

CURRENT_MD5=$(curl https://echo.artsy.net/Echo${NAME_POSTFIX}.json | md5_no_upd)
NEXT_MD5=$(cat $MIN_JSON | md5_no_upd)

if [ "$CURRENT_MD5" = "$NEXT_MD5" ]; then
  echo "No change in file besides `updated_at`. Skipping deployment."
  exit 0
fi


# upload a public copy and a private/backup copy
aws s3 cp "$MIN_JSON" "s3://artsy-public/eigen/Echo${NAME_POSTFIX}.json" --acl public-read
aws s3 cp "$MIN_JSON" "s3://artsy-public/eigen/Echo_$(date +%F)_$(git rev-parse --short HEAD)${NAME_POSTFIX}.json"


# add git tag
git tag --force deploy_$(date +%F)_$(git rev-parse --short HEAD)${NAME_POSTFIX}
git push --tags


# invalidate caching of file
aws cloudfront create-invalidation --distribution-id E1U95PW8WB8P0Z --paths /Echo${NAME_POSTFIX}.json




# no changes in json



