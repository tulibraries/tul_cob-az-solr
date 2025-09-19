#!/usr/bin/env bash
# GitHub Actions compatible test script

# Wait for Solr to be ready
echo "Waiting for Solr to be ready..."
for i in {1..30}; do
  if docker compose exec solr curl -s http://solr:8983/solr/admin/ping > /dev/null 2>&1; then
    echo "Solr is ready!"
    break
  fi
  echo "Waiting for Solr... (attempt $i/30)"
  sleep 5
done

# Check if the blacklight core exists and is healthy
echo "Checking blacklight core health..."
STATUS=$(docker compose exec solr curl -s http://solr:8983/solr/blacklight/admin/ping?wt=json | jq -r .status 2>/dev/null || echo "ERROR")

if [ "$STATUS" != "OK" ]; then
  echo "Failing because status is not OK"
  echo "status: $STATUS"
  
  # Debug information
  echo "=== Debug Information ==="
  echo "Available cores:"
  docker compose exec solr curl -s "http://solr:8983/solr/admin/cores?action=STATUS&wt=json" | jq .
  echo "Solr logs:"
  docker compose logs solr
  exit 1
fi

echo "Test passed! Solr core is healthy."
