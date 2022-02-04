# AWS-ORG cloud quark
is aws commands wrapper that automates creation of AWS Organizational Units.

Implements
````html
https://aws.amazon.com/blogs/mt/best-practices-for-organizational-units-with-aws-organizations/
````
Simply install at AWS CloudShell
````shell
curl -O https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-org/Makefile
````
```shell
% make help              
AWS-ORG cloud quark automates creation of AWS Organizational Units.
Usage: make <target> [parentId=<aws_ou_id>] [name=<aws_ou_name>]
Targets:
all              Creates Security, Infrastructure, Sandbox, Workloads, PolicyStaging, Deployments, Suspended OUs
help             Print this help
new              Creates a new OU with 'name' and 'parentId'
rootId           Returns the identity of the root
````
Customize AWS_ORG_UNITS list with your OUs and
````shell
make rootId | xargs -I{} make all parentId={}
````