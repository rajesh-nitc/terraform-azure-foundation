# terraform-azure-foundation

## Status

0. bootstrap - partially complete - deployed

1. org - partially complete - deployed

2. subscriptions - partially complete - deployed

3. networks - partially complete - not deployed

4. security - not started

5. aca-infra - partially complete - not deployed

6. aca-app - partially complete - not deployed

## Org hierarchy

![Alt text](images/image.png)

## Bootstrap
In this stage, we manually create a service principal ```sp-org-terraform``` with ```Owner``` role at ```mg-root ``` and run stages 0-4 manually using this sp. Other major resources that are created include terraform state bucket to store tfstate for stages 0-4.

## Org
Mainly org level resources like policy, centralized log analytics workspace, azure ad groups are created in this stage 

## Subscriptions
New subscription can be created using ```base_subscription``` module. These subscriptions will handed over to project teams. As part of creating new subscriptions, the following has been automated:
- Default rg, acr, kv, tfstate
- Uais like ```infra-cicd```, ```app-b-cicd``` (b for backend) and ```app-b```
- Federation of the uais with github openid auth so that project teams can run their infra cicd, app cicd on github actions
- Roles to uais on subscription
- Groups and roles to groups on subscription
- Gitub environment and secrets

## Networks
New networks hub and/or spoke can be created using single ```base_vnet``` module. As part of creating a vnet, the following has been automated:
- vnet, snet, nsg, nsg rules, routes for hub and/or spoke
- bastion, firewall in hub
- private endpoint and dns for acr and kv created in subscriptions stage
- option to enable nat on snet
- default snets

## Aca-infra
This stage is run on github actions using ```infra-cicd``` uai that was created in subscriptions stage

## Aca-app
This stage is run on github actions using ```app-b-cicd``` uai that was created in subscriptions stage