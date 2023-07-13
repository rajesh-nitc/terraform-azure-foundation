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
- Support for app type ```web-e-auth``` (external web app with azure ad auth) and ```web-e``` (external web app open to all)
- App registrations for ```web-e-auth```
- Github workflows that run with uais like ```infra-cicd```, ```[web-e-auth/web-e]-cicd```
- Federation of the uais with github openid auth so that project teams can run their ```infra-cicd```, [web-e-auth/web-e]-cicd on github actions
- Roles to cicd uais ```[web-e-auth/web-e]-cicd``` on subscription
- Roles to actual app uais ```[web-e-auth/web-e]``` on subscription 
- Groups and roles to groups on subscription
- ```Application Developer``` role to ```azure-devs``` group
- ```Application Administrator``` role to ```web-e-auth-cicd``` uai so that ```web-e-auth-cicd``` workflow can update the redirect uri for azure ad app registration
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
This stage is for project team and is run on github actions using ```[web-e-auth/web-e]-cicd``` uai that was handed over by platform/central team as part of subscriptions stage. Actual app[web-e-auth/web-e] runs with uai ```[web-e-auth/web-e]``` and can pull images from acr.