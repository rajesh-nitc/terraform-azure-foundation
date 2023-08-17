# terraform-azure-foundation

## Org hierarchy

![Alt text](images/org_hierarchy.png)

## Bootstrap
- ```mg-root``` under Root Management Group
- ```mg-bootstrap``` under ```mg-root```
- ```sub-bootstrap-tfstate``` under ```mg-bootstrap```
- tfstate container in ```sub-bootstrap-tfstate```
- ```terraform_service_principal```:
    - Owner role at ```mg-root```
    - Azure ad roles

## Org
Mainly org/platform level resources:
- Policy assignment at ```mg-root```
- Subscriptions under ```mg-common```:
    - ```sub-common-management```, ```sub-common-connectivity```
- Centralized log analytics workspace in ```sub-common-management```
- Azure ad groups:
    - Roles to Azure ad groups at ```mg-root```
- Budget alerts at ```mg-root``` and at ```sub-common-management```, ```sub-common-connectivity```
- Diagnostic settings at ```mg-root```

## Subscriptions
New project-level pay as you go subscription is created manually on the portal and is made ready to use using ```base_subscription``` module:
- Default rg, acr, kv, tfstate, law, budget alerts
- Github workflow uais: 
    - ```infra-cicd```, ```web-cicd```, ```api-cicd```
    - Roles to workflow uais at subscription
    - Federation of the workflow uais with github openid auth
- App uais:
    - ```web```, ```api``` 
    - Roles to app uais at subscription 
- App registrations:
    - ```web```, ```api```
- Azure ad groups:
    - Roles to Azure ad groups at subscription
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