DOCKER := docker compose

up:
	$(DOCKER) up -d
	$(DOCKER) exec app bundle install
down:
	$(DOCKER) down
tty-app:
	$(DOCKER) exec app bash
tty-solr:
	$(DOCKER) exec solr bash
ps:
	$(DOCKER) ps
zip:
	bash ./.circleci/build.sh