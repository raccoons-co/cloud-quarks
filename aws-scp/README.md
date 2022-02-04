# AWS SCP cloud quark
is aws commands wrapper that automates deployment of common AWS Service Control Policies

Simply install at AWS CloudShell
````html
curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-scp/Makefile --output Makefile
````
```shell
make help
AWS-SCP cloud quark automates deployment of common AWS Service Control Policies.
Usage: make <target> [policy=<scp_name>]
Targets:
deploy           Deploys AWS service control policy
help             Print this help
list             Lists all available AWS service control policies
show             Shows specified AWS service control policy
````
Deploy all
````shell
make list | xargs -I{} make deploy policy={}
````