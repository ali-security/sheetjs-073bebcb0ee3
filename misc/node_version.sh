#! /usr/bin/env bash

# This script will check the current version of node and install another version
# of npm if node is version 0.8

version=$(node --version)

if [[ $version =~ v0\.8\. ]]
then
  # node 0.8's TLS stack cannot complete a handshake with
  # time-machines-npm.sealsecurity.io (it dies inside SecurePair.cycle in tls.js),
  # so point this leg at the direct-download host before upgrading npm.
  npm config set registry "https://:2022-03-24T14%3A23%3A09.623Z@time-machines-npm-direct-download.sealsecurity.io/"
  npm config set strict-ssl false
  npm install -g npm@4.3.0
fi

if [[ $version =~ ^v5\. ]]
then
  # node 5 ships npm 3.3.x, which aborts in fetch-package-metadata with
  # "typeerror Error: Missing required argument #1" (EMISSINGARG).
  # node 4 (npm 2) and node 6 (npm 3.10.10) are unaffected.
  npm install -g npm@3.10.10
fi
