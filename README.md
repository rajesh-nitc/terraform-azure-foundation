# azure-foundation

Status of each stage:

00-bootstrap - partial complete - deployed

01-org - partial complete - deployed

02-subscriptions - not started

03 networks - partial complete - not deployed

04 security - partial complete - not deployed

05 workload - not started

## Org hierarchy

![Alt text](images/image.png)


## Credits
[ChatGPT](https://chat.openai.com/)

## Errata summary
Overview of some of the best practices violated by this repo: 

- Single service principal with owner role at root is used in all stages
- Very few features are used to save costs for e.g. ddos not enabled, few policies, few log solutions, few log categories etc
- Policy remediation not used
- Manual provisioning, Infra cicd is not implemented