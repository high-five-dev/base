.RECIPEPREFIX +=
.DEFAULT_GOAL := help

DDEV := $(shell command -v ddev 2> /dev/null)

DDEV_CONFIGURED := $(shell command ddev describe 2> /dev/null)

DDEV_DB ?= $(shell bash -c 'read -p "Database version [mariadb:10.4]" tmp; echo $${tmp:-mariadb:10.4}')
DDEV_PHP ?= $(shell bash -c 'read -p "PHP version [8.1]" tmp; echo $${tmp:-8.1}')
DDEV_NODE ?= $(shell bash -c 'read -p "Node.js version [16]" tmp; echo $${tmp:-16}')
DDEV_TLD ?= $(shell bash -c 'read -p "Domain tld [test]" tmp; echo $${tmp:-test}')

DDEV_NAME := $(shell echo $$(TMP=$$(basename $(CURDIR)); echo $${TMP%.*}))

help:
	@echo "  \033[33mUsage:\033[0m make [target] [arg=\"val\"...]\n\033[0m"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

conf:
ifndef DDEV
	@echo "\033[91m🙀 Ddev is not available, install it first!\033[0m";
	@exit 1
endif
ifndef DDEV_CONFIGURED
	@echo "\033[95m🪄 Setting up dev environment...\033[0m"
	@ddev config \
		--database=$(DDEV_DB) \
		--project-type=craftcms \
		--php-version=$(DDEV_PHP) \
		--nodejs-version=$(DDEV_NODE) \
		--docroot=httpdocs --create-docroot \
		--project-name=$(DDEV_NAME) \
		--project-tld=$(DDEV_TLD) \
		--timezone="Europe/Amsterdam"
	@ddev get drud/ddev-cron
endif

up:
	@if [ ! "$$(ddev describe | grep OK)" ]; then \
		ddev auth ssh; \
		ddev start; \
		echo "\033[95m🚀 Dev environment is up and running, go to lightspeed!\033[0m"; \
	else \
		echo "\033[95m🤖 Already running...\033[0m"; \
	fi

stop: ## Stop DDev environment
	@ddev stop

install: ## Install dependencies
	@ddev composer install
	@ddev npm i

dev: ## Start NPM dev server
	@ddev npm run dev

build: ## Build for production
	@ddev npm run build

db-export: ## Export database
	@mkdir -p sql
	@ddev export-db -f sql/$$(date +%Y%m%d%H%M%S)-backup.sql.gz

ddev: conf up ## Start DDev server

start: conf up install ## Start DDev server and install dependencies

serve: conf up install dev ## Start DDev server, install dependencies and start NPM dev server
