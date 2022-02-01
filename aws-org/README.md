# AWS-ORG cloud quark
is aws commands wrapper that automates creation of AWS Organizational Units.

Implements https://aws.amazon.com/blogs/mt/best-practices-for-organizational-units-with-aws-organizations/

Simply install at AWS CloudShell
````shell
curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile --output Makefile
````
```shell
$ make help
AWS-ORG cloud quark automates creation of AWS Organizational Units.
Usage: make <command> [parentId=<aws_org_id>] [name=<aws_ou_name>]
Commands:
additional       Creates additional OUs: Sandbox, Workloads, PolicyStaging, Deployments, Suspended
all              Creates foundational and additional OUs
foundational     Creates foundational OUs: Security and Infrastructure
help             Print this help
new              Creates a new OU with 'name' and 'parentId'
rootId           Returns the identity of the root
````
Customize AWS_ORG_UNITS list with your OUs and
````shell
make rootId | xargs -I{} make all parentId={}
````