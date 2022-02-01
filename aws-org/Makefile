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

define getRootId
	aws organizations list-roots
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

.PHONY: rootId
rootId: ## Returns the identity of the root
rootId: id = $(call getRootId)
rootId:
		@ eval $(id)

.PHONY: foundational
foundational: ## Creates foundational OUs: Security and Infrastructure
foundational: AWS_ORG_UNITS = Security Infrastructure
foundational: parentIdOptionRequired
	@ $(call createAll,$(AWS_ORG_UNITS))

# Issue: OU name with spaces is unavailable yet. Use make new for this purpose.
.PHONY: additional
additional: ## Creates additional OUs: Sandbox, Workloads, PolicyStaging, Deployments, Suspended
additional: AWS_ORG_UNITS = Sandbox Workloads PolicyStaging Deployments Suspended
additional: parentIdOptionRequired
	@ $(call createAll,$(AWS_ORG_UNITS))

# Use single quotes and escaping spaces 'Policy\ Staging' .
.PHONY: new
new: ## Creates a new OU specified with 'name' under 'parentId' OU
new: parentIdOptionRequired nameOptionRequired
	@ $(call newOrgUnit,$(name);)

.PHONY: all
all: parentIdOptionRequired
all: foundational additional
