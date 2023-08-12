# terraform-azure-foundation

## Org hierarchy

![Alt text](images/org_hierarchy.png)

## Bootstrap
In this stage, we manually create a service principal ```sp-org-terraform``` with ```Owner``` role at ```mg-root ``` and run stages 0-4 manually using this sp. Other major resources that are created include terraform state bucket to store tfstate for stages 0-4.

## Org
Mainly org/platform level resources:
- Policy assignment at ```mg-root```
- Management and connectivity subscriptions under ```mg-common```
- Centralized log analytics workspace in management subscription
- Azure ad groups
- Budget alerts at ```mg-root``` and at management and connectivity subscription
- Diagnostic settings at management, connectivity and dev subscription

## Subscriptions
New project-level subscription can be created using ```base_subscription``` module:
- Default rg, acr, kv, tfstate, law, budget alerts
- Github workflow uais: ```infra-cicd```, ```[web/api]-cicd```
- Roles to workflow uais on subscription
- Federation of the workflow uais with github openid auth
- App uais ```[web/api]``` and roles to app uais on subscription 
- App registration for ```web``` and ```api```
- Azure ad groups
- Roles to Azure ad groups on subscription
- Github repository environments and actions environment secrets

## Networks
New network hub or spoke can be created using single ```base_vnet``` module:
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
The app is made up of two Azure Container Apps: ```web``` and ```api```. Both are external at the moment. This stage is for project team and is run on github actions using workflow uais ```[web/api]-cicd```. Apps run with app uais ```[web/api]``` and can pull images from acr. 

After web app is deployed via github workflow, ```azure-devs``` group need to manually update the settings listed below:
- Update aad auth app created as part of subscriptions stage:
    - SPA redirect uri: ```$APP_URL/.auth/login/aad/callback```
    - Create client secret to use hybrid flow which will return access and refresh tokens
- Add authentication to container app and select existing aad auth app:
    - Issuer url: ```https://login.microsoftonline.com/$TENANT_ID/v2.0```

## Token store
Once token store feature is available to Azure Container Apps:
- Update ```REACT_APP_ENV=azure``` in ```aca_web.yaml```
- Update ```{"loginParameters":["scope=openid offline_access api://bu1-app1-api-dev/user_impersonation"]}``` on the ```web``` container app
- Enable easy auth on ```api``` container app
- Test if react app can get response from api