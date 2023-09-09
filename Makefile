include .docker/.env
export

DC_EXEC		= $(if $(shell which docker-compose),docker-compose,docker compose)
DC			= $(DC_EXEC) --project-directory=.docker --file=".docker/docker-compose.yaml"

PLATFORM		= $(shell uname -s)
CURRENT_UID		?= $(shell id -u)
CURRENT_GID		?= $(shell id -g)

.DEFAULT_GOAL      = help

.PHONY: help
help: ## Display help info
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' Makefile | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: build
build: ## Build image
	@$(DC) build

.PHONY: init
init: up ## Init application
	@$(DC) exec application bash -c 'yes | composer install --no-interaction'

.PHONY: up
up: ## Start the project docker containers
	@$(DC) up -d

.PHONY: down
down: ## Stop and remove the docker containers
	@$(DC) down --timeout 25

.PHONY: console
console: ## Enter into application container
	@$(DC) exec -it application bash

.PHONY: console-root
console-root: ## Enter into application container (as root)
	@$(DC) exec -it -u root application bash

.PHONY: serve
serve: up ## Run RR server (rr serve dev)
	@$(DC) exec application rr serve -c /app/.rr.dev.yaml
