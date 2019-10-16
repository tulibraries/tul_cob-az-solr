# TUL Catalog AZ (Lib Guides) Solr Configurations

These are the Solr configuration files for the TUL Catalog AZ (Lib Guides) search & faceting Solr collection.

## Prerequisites

- These configurations are built for Solr 8.1
- The instructions below presume a SolrCloud multi-node setup (using an external Zookeeper)


### Stage
Any tag/release created that ends in `-/[a-Z0-9]+` will be considered a non production release.  This will push the new config (`tul_cob-az-$TAG`) to our SolrCloud instance.

Then, a new empty collection with the same name will be pushed up.

Finally an alias will be created using the end of the tag that ends in `-[a-z0-9]+` as a suffix.  For example, the tag `foo-bar` will generate an  alias called `tul_cob-az-bar`, and the tag `foo-qa` will generate an alias called `tul_cob-az-qa`


### Production
Any tag/release created that *DOES NOT* end in `-/[a-Z0-9]+` will be considered a production release.

This workflow will require a manual approval step.

Once approved the workflow  will push the new config (`tul_cob-az-$TAG`) to our SolrCloud instance.

Then, a new empty collection with the same name will be pushed up.

Finally the alias `tul_cob-az` will be associated to the new empty collection.


