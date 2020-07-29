# You need setup here: ALIAS
ALIAS              = testrr
####

.DEFAULT_GOAL      = help
DEVELOPER_UID     ?= $(shell id -u)

BIN                = $(ALIAS)-application
COMPOSE            = docker-compose
DOCKER             = docker

#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
help:
	@echo -e '\033[1m make [TARGET] \033[0m'
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
	@echo && $(MAKE) -s env-info
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------

build: ## Build application image
	@cd ./.docker && $(COMPOSE) build --build-arg DEVELOPER_UID=${DEVELOPER_UID}

up: ## Start the docker hub (PHP, MySQL)
	@cd ./.docker && $(COMPOSE) up -d

down: ## Stop the docker hub
	@cd ./.docker && $(COMPOSE) down

stop: ## Start the docker hub
	@cd ./.docker && $(COMPOSE) stop

console: up ## Enter into application container
	$(DOCKER) exec -it -u root $(ALIAS)-application bash
