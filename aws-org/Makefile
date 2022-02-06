## AWS-ORG cloud quark
# is aws commands wrapper that automates creation of AWS Organizational Units.
#
# Implements
# https://aws.amazon.com/blogs/mt/best-practices-for-organizational-units-with-aws-organizations/
#
# Simply install at AWS CloudShell
# curl -O https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile
#
# make help
#
# Customize AWS_ORG_UNITS list with your OUs and
#   make rootId | xargs -I{} make all parentId={}

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# $(call AWSORG.getRootId) - Returns root Id of current AWS organisation
# Issue: Unknown effect if multiple roots
define AWSORG.getRootId
	aws organizations list-roots | grep -o '"Id": "[^"]*' | cut -d\" -f 4
endef

# $(call AWSORG.newUnit,$(name),$(parentId)) - Creates a new OU specified with name under parent OU id
define AWSORG.newUnit
	aws organizations create-organizational-unit --name $(1) --parent-id $(2)
endef

# Requires an explicit option to call the target. E.g. make <target> option=value.
.PHONY: requires.option(%)
requires.option(%):
	@ [ $($%) ] || ( $(MAKE) help; exit 1 )

.PHONY: help
help: ## Prints this help
	@ echo "AWS-ORG cloud quark automates creation of AWS Organizational Units."
	@ echo "Usage: make <target> [parentId=<aws_ou_id>] [name=<aws_ou_name>]"
	@ echo "Targets:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: rootId
rootId: ## Returns the identity of the root
	@ $(call AWSORG.getRootId)

# Use single quotes and escaping spaces to allow spaces i.e. 'Policy\ Staging'
.PHONY: new
new: ## Creates a new OU with 'name' and 'parentId'
new: requires.option(name)
new: requires.option(parentId)
	$(call AWSORG.newUnit,$(name),$(parentId))

.PHONY: all
all: ## Creates Security, Infrastructure, Sandbox, Workloads, PolicyStaging, Deployments, Suspended OUs
all: AWSORG.UNITS = Security Infrastructure Sandbox Workloads PolicyStaging Deployments Suspended
all: requires.option(parentId)
	$(foreach ou, $(AWSORG.UNITS), $(call AWSORG.newUnit,$(ou),$(parentId));)
