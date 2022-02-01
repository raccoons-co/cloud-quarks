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
	@ echo "Usage: make <command> [parentId=<aws_org_id>] [name=<aws_ou_name>]"
	@ echo "Commands:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# Checks is specifying policy parentId option is strictly required.
.PHONY: parentIdOptionRequired
parentIdOptionRequired:
	@ [ $(parentId) ] || ( make help; exit 1 )

.PHONY: nameOptionRequired
nameOptionRequired:
	@ [ $(name) ] || ( make help; exit 1 )

.PHONY: getRoot
getRoot: ## Returns the identity of the root
	@ aws organizations list-roots

.PHONY: foundational
foundational: AWS_ORG_UNITS = Security Infrastructure
foundational: parentIdOptionRequired ## Creates foundational OUs
	@ $(call createAll,$(AWS_ORG_UNITS))

.PHONY: new
new: parentIdOptionRequired nameOptionRequired ## Creates a new OU specified with 'name' under 'parentId' OU
	@ $(call newOrgUnit,$(ou);)
