DOCKER := docker compose

up:
	$(DOCKER) up -d
	# Force bundler to compile gems from source to avoid ABI version conflicts
	$(DOCKER) exec app bundle config set force_ruby_platform true
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
	bash ./.github/scripts/build.sh
zip-gh:
	bash ./.github/scripts/build.sh