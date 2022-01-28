# Welcome to AWS CDK Java applications world

## Prerequisites of your environment
- Debian GNU/Linux, Amazon Linux or macOS
- All AWS CDK applications require Node.js 10.13 or later

## Simply run
````sh
curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-cdk/Makefile --output Makefile
````
````sh
make aws-cdk
````
````sh
make init-cdk-app project=<NAME>
````
````sh
cd <NAME>
git remote add origin https://github.com/<ACCOUNT>/<NAME>.git
git branch -M main
````
Then open project in IntelliJ IDEA and `push` changes to remote

Run `make` or `make help` to list available commands.

## Further reading
- [AWS CDK Reference Documentation](https://docs.aws.amazon.com/cdk/api/v2/)
- [AWS CDK Java Examples](https://github.com/aws-samples/aws-cdk-examples/tree/master/java)
