# This wrapper automates setup of AWS ORG cloud quarks.
# Simply install at AWS CloudShell
#   curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile --output Makefile

# Describes AWS ORG cloud quark repository URL
CLOUD_QUARK=https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-sorg


# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# Using 'sh -c' can avoid situation then VCS do not preserves file permissions
sh_c := sh -c

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
	aws organizations create-organizational-unit --parent-id $(root) --name $(1)
endef

.PHONY: getRoot
getRoot: ## Returns the identity of the root
	@ aws organizations list-roots

.PHONY: sandbox
sandbox: parentIdOptionRequired ## Creates 'Sandbox' OU
	@ $(call createOU,Sandbox)

.PHONY: workloads
workloads: parentIdOptionRequired ## Creates 'Workloads' OU
	@ $(call createOU,Workloads)

.PHONY: suspended
suspended: parentIdOptionRequired ## Creates 'Suspended' OU
	@ $(call createOU,Suspended)

.PHONY: all
all: sandbox suspended ## Creates all OUs
