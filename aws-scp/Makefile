# This wrapper automates setup of AWS SCP cloud quarks.
# Simply install with
#   curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/Makefile --output Makefile

# Defines default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# Using 'sh -c' can avoid situation then VCS do not preserves file permissions
sh_c := sh -c

.PHONY: help
help: ## Print this help
	@ echo "List of available commands:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

ifndef profile
  profile=default
endif

.PHONY: policyOptionRequired
policyOptionRequired:
	@ [ $(policy) ] || ( echo "Usage: make <command> policy=<name>" ; exit 1 )

.PHONY: create
create: policyOptionRequired ## Creates a service control policy
	aws organizations create-policy \
                 --content https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/$(policy).json \
                 --description $(policy) \
                 --name $(policy) \
                 --type SERVICE_CONTROL_POLICY \
                 --profile $(profile)

.PHONY: open-repo
open-repo: ## Opens GitHub repository with AWS service control policies
	open https://github.com/raccoons-co/cloud-quarks/tree/main/aws-scp

.PHONY: list
list: ## Lists all available SCPs
	@ curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/list

.PHONY: show
show: policyOptionRequired ## Shows specified SCP policy=DenyAll
	@ curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/$(policy).json
