.DEFAULT_GOAL := help

# Using 'sh -c' can avoid situation then VCS do not preserves file permissions
sh_c := sh -c


.PHONY: help
help: ## Print this help
	@echo "List of available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install-aws-cdk
install-aws-cdk: depends ## Install AWS-CDK
	$(sh_c) 'sudo npm install -g aws-cdk'
	
.PHONY: init-sample
init-sample: ## Initialize AWS CDK Java app sample
	$(sh_c) 'mkdir ~/hello-cdk && cd ~/hello-cdk && cdk init app --language java'

.PHONY: build-sample
build-sample: ## Build AWS CDK Java app sample
	$(sh_c) 'cd ~/hello-cdk && mvn compile -q'
	
.PHONY: clean
clean: ## Clean workspace
	$(sh_c) 'rm -rf ~/hello-cdk/'

.PHONY: depends
depends: ## Install software dependencies
	$(sh_c) 'git config --global user.email "ok@raccoons.co" && git config --global user.name "raccoon1"'
	$(sh_c) 'sudo yum install -y maven'
