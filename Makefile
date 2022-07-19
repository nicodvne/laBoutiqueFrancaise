PHP_CONTAINER=www
SHELL_PROJECT=@docker exec -ti $(PHP_CONTAINER) sh -c
CD_PROJECT= cd /var/www/project

SYMFONY = bin/console

.DEFAULT_GOAL = help



help:
	@echo "Je sais pas quoi dire lol"

connect:
	$(SHELL_PROJECT) " $(CD_PROJECT) && /bin/bash "

install:
	$(SHELL_PROJECT) " $(CD_PROJECT) && composer install"

update:
	$(SHELL_PROJECT) " $(CD_PROJECT) && composer update"

start:
	@cd .. && docker-compose up -d

stop:
	@cd .. &&  docker-compose down

entity:
	$(SHELL_PROJECT) " $(CD_PROJECT) && $(SYMFONY) make:entity"

controller:
	$(SHELL_PROJECT) " $(CD_PROJECT) && $(SYMFONY) make:controller"

migration:
	$(SHELL_PROJECT) " $(CD_PROJECT) && $(SYMFONY) make:migration"

generate-migration:
	$(SHELL_PROJECT) " $(CD_PROJECT) && $(SYMFONY) doctrine:migrations:generate"

migrate:
	$(SHELL_PROJECT) " $(CD_PROJECT) && $(SYMFONY) d:m:m"ma