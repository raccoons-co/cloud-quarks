.DEFAULT_GOAL := help

# Using 'sh -c' can avoid situation then VCS do not preserves file permissions
sh_c := sh -c


.PHONY: help
help: ## Print this help
	@echo "List of available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: aws-cdk
aws-cdk: depends ## Run linter for YAML files
	$(sh_c) 'sudo npm install -g aws-cdk && cdk --version'
	$(sh_c) 'cdk --version'
	
