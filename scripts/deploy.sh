#!/usr/bin/env bash
set -euxo pipefail


# prepare files
mkdir -p build
node scripts/prepare.js


# upload a public copy and a private/backup copy
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo.json --acl public-read
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo_$(date +%F)_$(git rev-parse --short HEAD).json


#### what about staging?

### dont upload if nothing changed?


### only do this in master

		# // invalidate cloudflare
