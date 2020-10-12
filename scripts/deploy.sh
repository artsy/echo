#!/usr/bin/env bash
set -euxo pipefail


# prepare files
mkdir -p build
node scripts/prepare.js


# upload
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo.json
aws s3 cp build/Echo.min.json s3://artsy-public/eigen/Echo_$(date +%F)_$(git rev-parse --short HEAD).json






### only do this in master

		# // invalidate cloudflare

