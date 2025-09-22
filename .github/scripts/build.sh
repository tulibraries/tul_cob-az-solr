#!/usr/bin/env bash
set -e
# GitHub Actions compatible build script
zip -r "$HOME/solrconfig.zip" . -x ".git*" \
  "Gemfile" "Gemfile.lock" "spec/*" "vendor/*" \
  "Makefile" ".github*" "LICENSE" "README*" \
  "docker-compose.yml"
