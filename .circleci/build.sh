#!/usr/bin/env bash
set -e
zip -r ~/solrconfig.zip . -x ".git*" \
  Gemfile Gemfile.lock "spec/*" "vendor/*" \
  Makefile ".circle*" LICENSE "README*" \
  docker-compose.yml
