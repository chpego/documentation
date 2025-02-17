.DEFAULT_GOAL := help

help: ## Shows help message.
	@printf "\033[1m%s\033[36m %s\033[32m %s\033[0m \n\n" "Development environment for" "HACS" "Documentation";
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m make %-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST);
	@echo

init: bootstrap

start: generate ## Start the documentation server
	yarn start;

bootstrap: ## Run yarn
	apt update
	apt install -y python3-pip
	rm -rf documentation/repositories
	yarn global add prettier;
	yarn;

generate: ## Build the documentation
	python3 -m pip install requests
	python3 script/generate_default_repositories.py

update: ## Pull main from hacs/documentation
	git pull upstream main;
