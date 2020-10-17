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

NEXT_JSON=$MIN_JSON

function md5_no_upd {
  cat "$1" | perl -pe 's|,"updated_at":".+?"||' | md5
}

CURRENT_MD5=$(md5_no_upd $CURRENT_JSON)
NEXT_MD5=$(md5_no_upd $NEXT_JSON)

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




### dont upload if nothing changed? check latest `deploy-*` tag, check if Echo.json changed? also have a way to force deploy, just in case

# invalidate caching of file
aws cloudfront create-invalidation --distribution-id E1U95PW8WB8P0Z --paths /Echo${NAME_POSTFIX}.json
