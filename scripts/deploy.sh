#!/usr/bin/env bash
set -euxo pipefail


# prepare files
mkdir -p build
node scripts/prepare.js


# upload a public copy and a private/backup copy
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo.json --acl public-read
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo_$(date +%F)_$(git rev-parse --short HEAD).json


# add git tag
# git tag deploy_$(date +%F)_$(git rev-parse --short HEAD)
# git push --tags


## only run this script on master and prod. master goes to echo.staging.json, prod goes to echo.json

## make a pr from master to prod branch (auto, like force?)

### dont upload if nothing changed? check latest `deploy-*` tag, check if Echo.json changed? also have a way to force deploy, just in case

# invalidate caching of file
aws cloudfront create-invalidation --distribution-id E1U95PW8WB8P0Z --paths /Echo.json
