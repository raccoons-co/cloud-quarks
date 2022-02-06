# AWS SCP cloud quark
# is aws commands wrapper that automates deployment of common AWS Service Control Policies
#
# Simply install at AWS CloudShell
# curl -O https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/Makefile
#
# make help
#
# Deploy all
# make list | xargs -I{} make deploy policy={}

CQ_BASE_URL = https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp
CQ_HOME_DIR = ~/.cloud-quark/aws-scp

# Sets default target to handle make execution with no arguments
.DEFAULT_GOAL := help

# Requires an explicit option to call the target. E.g. make <target> option=value.
.PHONY: requires.option(%)
requires.option(%):
	@ [ $($%) ] || ( $(MAKE) help; exit 1 )

# Transfers cloud quark from remote
.PHONY: http.get(%)
http.get(%):
	@ curl -fsSL -H 'Cache-Control: no-cache' $(CQ_BASE_URL)/$%

# Makes Cloud Quark home directory if not exists. Create intermediate directories as required.
$(CQ_HOME_DIR):
	@ [ -d $@ ] || mkdir -p $@

# Creates policy JSON file under CQ_HOME_DIR
$(CQ_HOME_DIR)/%.json: $(CQ_HOME_DIR) # Depends on home directory
	@ curl -fsSL -H 'Cache-Control: no-cache' $(CQ_BASE_URL)/$(@F) \
		--output $@

# Creates AWS SCP in your AWS organization
.PHONY: AWSSCP.new(%)
AWSSCP.new(%): $(CQ_HOME_DIR)/%.json # Depends on downloaded SCP JSON file
	aws organizations create-policy \
		--type SERVICE_CONTROL_POLICY \
		--name $% \
		--description $% \
		--content file://$<

.PHONY: help
help: ## Prints this help
	@ echo "AWS-SCP cloud quark automates deployment of common AWS Service Control Policies."
	@ echo "Usage: make <target> [policy=<aws_scp_name>]"
	@ echo "Targets:"
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: list
list: http.get(list) ## Lists all available AWS service control policies

.PHONY: show
show: requires.option(policy)
show: http.get($(policy).json) ## Shows specified AWS service control policy

.PHONY: deploy
deploy: requires.option(policy)
deploy: AWSSCP.new($(policy)) ## Deploys a new AWS service control policy
