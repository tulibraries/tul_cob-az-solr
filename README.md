# TUL Catalog AZ (Lib Guides) Solr Configurations

These are the Solr configuration files for the TUL Catalog AZ (Lib Guides) search & faceting Solr collection.

## Prerequisites

- These configurations are built for Solr 8.1
- The instructions below presume a SolrCloud multi-node setup (using an external Zookeeper)

### Deployment Process
There is no distinction made between a production vs. non-production deployment.

All deployments proceed as follows:

* The configset (`tul_cob-az-$TAG`) is pushed to the SolrCloud instance.
* Then, a new empty collection with the same name will be pushed up.
* Creates an alias based on the configset (ex. `tul_cob-az-v1-qa`).
* Creates a generic alias using the end of the tag that ends in `-[a-z0-9]+` as a suffix.
  * But only if it doesn't already exist.
