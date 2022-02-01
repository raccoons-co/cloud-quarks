# This wrapper automates setup of AWS ORG cloud quarks.
# Simply install at AWS CloudShell
#   curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile --output Makefile

FOUNDATIONAL_ORG_UNITS = Security Infrastructure
ADDITIONAL_ORG_UNITS = Sandbox Workloads 'Policy Staging' Suspended Deployments

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this help
	@ echo "Usage: make <command> [parentId=<aws_org_id>]"
	@ echo "Commands:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# Checks is specifying policy parentId option is strictly required.
.PHONY: parentIdOptionRequired
parentIdOptionRequired:
	@ [ $(parentId) ] || ( make help; exit 1 )

define createOU
	aws organizations create-organizational-unit --parent-id $(parentId) --name $(1)
endef

.PHONY: getRoot
getRoot: ## Returns the identity of the root
	@ aws organizations list-roots

.PHONY: foundational
foundational: parentIdOptionRequired ## Creates foundational OUs
	@ $(foreach ou, $(FOUNDATIONAL_ORG_UNITS), $(call createOU,$(ou);))

.PHONY: additional
additional: parentIdOptionRequired ## Creates additional OUs
	@ $(foreach ou, $(ADDITIONAL_ORG_UNITS), $(call createOU,$(ou);))

.PHONY: all
all: foundational additional