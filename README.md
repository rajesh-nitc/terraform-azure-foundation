# terraform-azure-foundation

## Org hierarchy

![Alt text](images/org_hierarchy.png)

## Bootstrap
- ```mg-root``` under Root Management Group
- ```mg-bootstrap``` under ```mg-root```
- Move default subscription under ```mg-bootstrap```
- terraform state container
- terraform_service_principal:
    - Azure resource roles: ```Owner``` role at ```mg-root```
    - Azure ad roles: ```Application.ReadWrite.All```, ```Directory.ReadWrite.All```, ```RoleManagement.ReadWrite.Directory```

## Org
Mainly org/platform level resources:
- Policy assignment at ```mg-root```
- Move subscriptions under ```mg-common```
- Centralized log analytics workspace in management sub
- Budget alerts at ```mg-root``` and at subs under ```mg-common```
- Diagnostic settings at ```mg-root```
- Azure ad groups:
    - Azure resource roles to Azure ad groups at ```mg-root```

## Subscriptions
New project-level subscription is created manually on the portal and is made ready to use using ```base_subscription``` module:
- Default rg, acr, kv, tfstate, law, budget alerts
- Github workflow uais: 
    - ```infra-cicd```, ```web-cicd```, ```api-cicd```
    - Azure resource roles to workflow uais at subscription
    - Federation of the workflow uais with github openid auth
- App uais:
    - ```web```, ```api``` 
    - Azure resource roles such as ```AcrPull``` to app uais at subscription 
- Azure ad groups:
    - Azure resource roles to Azure ad groups at subscription
    - Azure ad roles such as ```Application Developer``` to ```azure-devs``` group
- App registrations:
    - ```azure-devs``` group need to manually update ```API Permissions```:
        - Grant admin consent to api permissions for ```api```
        - Go to ```web ``` -> API Permissions -> Add a permission -> APIs my organization uses -> type client id of ```api``` -> select permission ```user_impersonation``` (which was configured by the module)
- Github repository environments and actions environment secrets

## Networks
New network hub or spoke can be created using single ```base_vnet``` module:
- rg-net, hub/spoke vnet, snet, nsg, nsg rules, routes
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
- Add authentication to container app and select existing aad auth app:
    - Issuer url: ```https://login.microsoftonline.com/$TENANT_ID/v2.0```

## Token store
Once token store feature is available to Azure Container Apps:
- Update ```REACT_APP_ENV=azure``` in ```aca_web.yaml```
- Update ```{"loginParameters":["scope=openid offline_access api://bu1-app1-api-dev/user_impersonation"]}``` on the ```web``` container app
- Enable easy auth on ```api``` container app
- Test if react app can get response from api