# AWS-ORG cloud quark is aws commands wrapper that automates creation of AWS Organizational Units.
# Implements
# https://aws.amazon.com/blogs/mt/best-practices-for-organizational-units-with-aws-organizations/
#
# Simply install at AWS CloudShell
# 	curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile --output Makefile
#   make help
#
# Edit AWS_ORG_UNITS and
# 	make rootId | xargs -I{} make all parentId={}

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# $(call getRootId) - Returns root Id of current AWS organisation
# Issue: Unknown effect if multiple roots
define getRootId
	aws organizations list-roots | grep -o '"Id": "[^"]*' | cut -d\" -f 4
endef

# $(call newOrgUnit,$(name),$(parentId)) - Creates a new OU specified with name under parent OU id
define newOrgUnit
	aws organizations create-organizational-unit --name $(1) --parent-id $(2)
endef

# $(call createAll,$(AWS_ORG_UNITS),$(parentId)) - Creates OUs specified as list of names
define createAll
	$(foreach ou, $(1), $(call newOrgUnit,$(ou),$(2));)
endef

.PHONY: help
help: ## Print this help
	@ echo "AWS-ORG cloud quark automates creation of AWS Organizational Units."
	@ echo "Usage: make <target> [parentId=<aws_ou_id>] [name=<aws_ou_name>]"
	@ echo "Targets:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# Requires specifying parentId option to make a target.
.PHONY: parentIdOptionRequired
parentIdOptionRequired:
	@ [ $(parentId) ] || ( make help; exit 1 )

# Requires specifying name option to make a target.
.PHONY: nameOptionRequired
nameOptionRequired:
	@ [ $(name) ] || ( make help; exit 1 )

.PHONY: rootId
rootId: ## Returns the identity of the root
rootId:
	@ $(call getRootId)

# Use single quotes and escaping spaces to allow spaces i.e. 'Policy\ Staging'
.PHONY: new
new: ## Creates a new OU with 'name' and 'parentId'
new: parentIdOptionRequired nameOptionRequired
	@ $(call newOrgUnit,$(name),$(parentId))

.PHONY: all
all: ## Creates Security, Infrastructure, Sandbox, Workloads, PolicyStaging, Deployments, Suspended OUs
all: AWS_ORG_UNITS = Security Infrastructure Sandbox Workloads PolicyStaging Deployments Suspended
all: parentIdOptionRequired
	@ $(call createAll,$(AWS_ORG_UNITS),$(parentId))
