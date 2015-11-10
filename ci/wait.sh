#!/usr/bin/env bash

function test_postgresql {
  pg_isready -h "${DATABASE_HOST}" -U "${DATABASE_USER}"
}

count=0

until ( test_postgresql )
do
  ((count++))
  if [ ${count} -gt 50 ]
  then
    echo "Services didn't become ready in time"
    exit 1
  fi
  sleep 0.1
done
