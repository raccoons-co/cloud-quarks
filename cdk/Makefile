.DEFAULT_GOAL := help

# Using 'sh -c' can avoid situation then VCS do not preserves file permissions
sh_c := sh -c


.PHONY: help
help: ## Print this help
	@echo "List of available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install-aws-cdk
install-aws-cdk: depends ## Run linter for YAML files
	$(sh_c) 'sudo npm install -g aws-cdk && cdk --version'
	
.PHONY: init-cdk-java-sample
init-cdk-java-sample: depends ## Run linter for YAML files
	$(sh_c) 'mkdir ~/hello-cdk \
		&& cd ~/hello-cdk \
		&& cdk init app --language java'

.PHONY: depends
depends: ## Install software dependencies
	$(sh_c) 'sudo yum install -y mc'
