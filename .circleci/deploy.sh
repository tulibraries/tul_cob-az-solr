#!/usr/bin/env bash
set -e

validate_status() {
  echo "response: $RESP"

  STATUS=$(echo "$RESP" | grep HTTP | awk '{print $2}')

  if [[  "$STATUS" != "200" ]]; then
    echo "Failing because status was not 200"
    echo "status: $STATUS"
    exit 1
  fi
}

echo
echo "***"
echo "* Sending tul_cob-az-$CIRCLE_TAG configs to SolrCloud."
echo "***"
RESP=$(curl -u $SOLR_USER:$SOLR_PASSWORD -i -o - --silent -X POST --header "Content-Type:application/octet-stream" --data-binary @/home/circleci/solrconfig.zip "https://solrcloud.tul-infra.page/solr/admin/configs?action=UPLOAD&name=tul_cob-az-$CIRCLE_TAG")
validate_status

echo
echo "***"
echo "* Creating new tul_cob-az-$CIRCLE_TAG collection"
echo "***"
RESP=$(curl -u $SOLR_USER:$SOLR_PASSWORD -i -o - --silent -X GET --header 'Accept: application/json' "https://solrcloud.tul-infra.page/solr/admin/collections?action=CREATE&name=tul_cob-az-$CIRCLE_TAG&numShards=1&replicationFactor=2&maxShardsPerNode=1&collection.configName=tul_cob-az-$CIRCLE_TAG")
validate_status


ALIAS_SUFFIX=$(echo $CIRCLE_TAG | sed -E 's/.*(-[A-z0-9]+)$/\1/' | grep '\-[A-z0-9]\+$')

if [ "$ALIAS_SUFFIX" == "" ]; then
  echo
  echo "***"
  echo "* Skipping alias for production setting"
  echo "***"
else
  echo
  echo "***"
  echo "* Aliasing tul_cob-az-$CIRCLE_TAG to tul_cob-az$ALIAS_SUFFIX"
  echo "***"
  RESP=$(curl -u $SOLR_USER:$SOLR_PASSWORD -i -o - --silent -X POST --header "Content-Type:application/octet-stream" "https://solrcloud.tul-infra.page/solr/admin/collections?action=CREATEALIAS&name=tul_cob-az$ALIAS_SUFFIX&collections=tul_cob-az-$CIRCLE_TAG")
  validate_status
fi
