# This wrapper automates setup of AWS ORG cloud quarks.
# Simply install at AWS CloudShell
#   curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile --output Makefile

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# Creates a new OU
define newOrgUnit
	aws organizations create-organizational-unit --parent-id $(parentId) --name $(1)
endef

# Creates OUs provided as list
define createAll
	$(foreach ou, $(1), $(call newOrgUnit,$(ou);))
endef

.PHONY: help
help: ## Print this help
	@ echo "Usage: make <command> [parentId=<aws_org_id>]"
	@ echo "Commands:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# Checks is specifying policy parentId option is strictly required.
.PHONY: parentIdOptionRequired
parentIdOptionRequired:
	@ [ $(parentId) ] || ( make help; exit 1 )

.PHONY: getRoot
getRoot: ## Returns the identity of the root
	@ aws organizations list-roots

.PHONY: foundational
foundational: AWS_ORG_UNITS = Security Infrastructure
foundational: parentIdOptionRequired ## Creates foundational OUs
	@ $(call createAll,$(AWS_ORG_UNITS))

.PHONY: additional
additional: AWS_ORG_UNITS = Sandbox Workloads Deployments Suspended
additional: parentIdOptionRequired ## Creates additional OUs
	@ $(call createAll,$(AWS_ORG_UNITS))

.PHONY: all
all: foundational additional ## Creates foundational and additional OUs
