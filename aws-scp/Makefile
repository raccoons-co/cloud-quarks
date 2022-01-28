# This wrapper automates setup of AWS SCP cloud quarks.
# Simply install with
#   curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/Makefile --output Makefile

# Describes AWS SCP cloud quark repository URL
CLOUD_QUARK=https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp

# Sets default AWS profile if it’s not already set.
profile ?= default

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this help
	@ echo "Usage: make <command> [policy=<scp_name>] [profile=<aws_profile>]"
	@ echo "Commands:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# Checks is specifying policy option is strictly required.
.PHONY: policyOptionRequired
policyOptionRequired:
	@ [ $(policy) ] || ( make help; exit 1 )

.PHONY: list
list: ## Lists all available AWS service control policies
	@ curl -fsSL $(CLOUD_QUARK)/list

.PHONY: show
show: policyOptionRequired ## Shows specified AWS service control policy
	@ curl -fsSL $(CLOUD_QUARK)/$(policy).json

.PHONY: create
create: policyOptionRequired ## Creates a service control policy in your AWS environment
	aws organizations create-policy \
                 --content $(CLOUD_QUARK)/$(policy).json \
                 --description $(policy) \
                 --name $(policy) \
                 --type SERVICE_CONTROL_POLICY \
                 --profile $(profile)
