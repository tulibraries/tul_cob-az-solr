#!/usr/bin/env bash
STATUS=$(curl http://localhost:8090/solr/tul_cob-az/admin/ping?wt=json | jq .status)

if [ "$STATUS" != '"OK"' ]; then
  echo "Faling because status is not OK"
  echo "status: $STATUS"
  exit -1
fi
