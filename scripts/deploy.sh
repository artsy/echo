#!/usr/bin/env bash
set -euxo pipefail


# prepare files
mkdir -p build
node scripts/prepare.js


# upload a public copy and a private/backup copy
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo.json --acl public-read
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo_$(date +%F)_$(git rev-parse --short HEAD).json


#### what about staging?

# add git tag
git tag deploy-$(date +%F)
git push --tags

### dont upload if nothing changed? check latest `deploy-*` tag, check if Echo.json changed? also have a way to force deploy, just in case


### only do this in master

		# // invalidate cloudflare
