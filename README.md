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
Mainly org level resources like policy, centralized log analytics workspace, azure ad groups are created in this stage. 

## Subscriptions
New subscription can be created using ```base_subscription``` module. These subscriptions will be handed over to project teams. As part of creating new subscriptions, the following has been automated:
- Default rg, acr, kv, tfstate
- Support for app type ```webspa```, ```web```, ```api```. spa is single page application. ```api``` is internal
- App registrations for ```[webspa/web]```
- Github workflows that run with uais like ```infra-cicd```, ```[webspa/web/api]-cicd```
- Federation of the uais with github openid auth so that project teams can run their ```infra-cicd```, ```[webspa/web/api]-cicd``` on github actions
- Roles to cicd uais ```[webspa/web/api]-cicd``` on subscription
- Roles to actual app uais ```[webspa/web/api]``` on subscription 
- Groups and roles to groups on subscription
- ```Application Developer``` role to ```azure-devs``` group
- ```Application Administrator``` role to ```[webspa/web]-cicd``` uai so that ```[webspa/web]-cicd``` workflow can update the redirect uri for azure ad app registration
- Github environments and secrets

## Networks
New network hub or spoke can be created using single ```base_vnet``` module. As part of creating a vnet, the following has been automated:
- vnet, snet, nsg, nsg rules, routes
- bastion, firewall
- private endpoint and dns for default acr and kv created in subscriptions stage
- option to enable nat on snet
- default snets like private endpoint subnet

## Aca-infra
This stage is for project team and is run on github actions using ```infra-cicd``` uai that was handed over by platform/central team as part of subscriptions stage.

## Aca-app
This stage is for project team and is run on github actions using ```[webspa/web/api]-cicd``` uai. Actual apps run with uai ```[webspa/web/api]``` and can pull images from acr.