# AWS SCP cloud quark
# is aws commands wrapper that automates deployment of common AWS Service Control Policies
#
# Simply install at AWS CloudShell
# curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/Makefile --output Makefile

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# $(call createPolicy,$(policy))
define createPolicy
	aws organizations create-policy \
				 --type SERVICE_CONTROL_POLICY \
				 --name $(1) \
				 --description $(1) \
                 --content file://.cloud-quark/aws-scp/$(1)
endef

# $(call httpGet,$(page))
define httpGet
	curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/$(1)
endef

.PHONY: help
help: ## Print this help
	@ echo "Usage: make <command> [policy=<scp_name>]"
	@ echo "Commands:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# Checks is specifying policy option is strictly required.
.PHONY: policyOptionRequired
policyOptionRequired:
	@ [ $(policy) ] || ( make help; exit 1 )

.PHONY: list
list: ## Lists all available AWS service control policies
	@ $(call httpGet,list)

.PHONY: show
show: policyOptionRequired ## Shows specified AWS service control policy
	@ $(call httpGet,$(policy).json)

.PHONY: create
create: policyOptionRequired ## Creates a service control policy in your AWS environment
	$(call createPolicy,$(policy))
