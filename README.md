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
- Github workflow uais: ```infra-cicd```, ```[webspa/web/api]-cicd```
- Roles to workflow uais on subscription
- Federation of the workflow uais with github openid auth
- App uais ```[webspa/web/api]``` and roles to app uais on subscription 
- Groups and roles to groups on subscription
- App registrations
- Github environments and secrets

## Networks
New network hub or spoke can be created using single ```base_vnet``` module. As part of creating a vnet, the following has been automated:
- rg-net, vnet, snet, nsg, nsg rules, routes
- hub/spoke vnet peering
- private dns zones in hub
- private endpoints in spoke 
- bastion, firewall in hub
- enable nat on snet
- default snets like private endpoint subnet

## Aca-infra
This stage is for project team and is run on github actions using workflow uai ```infra-cicd``` that was handed over by platform/central team as part of subscriptions stage.

## Aca-app
The app is made up of ```webspa``` (which is external but require authentication with azure ad) and ```api``` (which is internal). This stage is for project team and is run on github actions using workflow uais ```[webspa/web/api]-cicd```. Apps run with app uais ```[webspa/web/api]``` and can pull images from acr. 

```azure-devs``` group will be updating these manually on the portal after aca webspa is deployed through github workflow:
- Redirect uri for webspa
- Session affinity