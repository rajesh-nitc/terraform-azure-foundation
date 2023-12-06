# terraform-azure-foundation
This repo shows how to build a simple and secure foundation on Azure. Later, we use the foundation to deploy a simple hello-world enterprise app that is accessible to all authenticated employees over the Internet. This app will have a frontend webapp on aca, apim and backend api on aca. Easy auth is enabled on webapp.

## Org hierarchy

![Alt text](images/org_hierarchy.png)

## Bootstrap
- Create ```mg-root``` under Root Management Group
- Create ```mg-bootstrap``` under ```mg-root```
- Move default pay as you go subscription ```sub-bootstrap-tfstate``` under ```mg-bootstrap```
- Create terraform resources in ```sub-bootstrap-tfstate```:
    - terraform state container: ```stct-org-tfstate```
    - terraform service principal: ```sp-terraform-foundation```
        - Grant Azure resource roles at ```mg-root```: ```Owner``` and ```Storage Blob Data Contributor``` 
        - Grant Azure ad roles: ```Application.ReadWrite.All```, ```Directory.ReadWrite.All```, ```RoleManagement.ReadWrite.Directory```

## Org
Mainly org/platform level resources are created in this stage:
- Create ```mg-common``` under ```mg-root```
- Create policy assignment at ```mg-root```
- Move subscriptions ```sub-common-management``` and ```sub-common-connectivity``` under ```mg-common```
- Create centralized log analytics workspace in ```sub-common-management```
- Create budget alerts at ```mg-root``` and at ```sub-common-management``` and ```sub-common-connectivity```
- Create diagnostic settings at ```mg-root```
- Create org/platform level Azure ad groups:
    - Grant Azure resource roles at ```mg-root```

## Subscriptions
New project-level subscription is created manually on the portal and is made ready to use using ```base_subscription``` module:
- Create default rg, acr, kv, tfstate, law, budget alerts
- Create github workflow uais: ```infra-cicd```, ```web-cicd```, ```api-cicd```
    - Grant Azure resource roles at subscription
    - Federate workflow uais with github openid auth
- Create app uais: ```web```, ```api```: 
    - Grant Azure resource roles such as ```AcrPull``` at subscription 
- Create project-level Azure ad groups:
    - Grant Azure resource roles at subscription
    - Grant Azure ad roles for e.g. ```Application Developer``` to ```azure-devs``` group
- Create app registration for web
- Create github repository environments and actions environment secrets

## Networks
New network hub or spoke can be created using single ```base_vnet``` module:
- Create rg-net, hub/spoke vnet, snet, nsg, nsg rules, routes
- Create hub/spoke vnet peering
- Create private dns zones in hub
- Create private endpoints in spoke 
- Create bastion, firewall in hub
- Create snets in spoke: private endpoint, appgw, apim

## Aca-infra
This stage is for project team and is run on github actions using workflow uai ```infra-cicd``` that was handed over by platform/central team as part of subscriptions stage.

## Aca-app
This stage is for project team and is run on github actions using workflow uais ```[web/api]-cicd```. Apps run with app uais ```[web/api]``` and can pull images from acr. 

Before weapp is deployed via github workflow, create a github secret REACT_APP_APIM_KEY

After web app is deployed via github workflow, ```azure-devs``` group need to manually update the settings listed below:
- Update aad auth app created as part of subscriptions stage:
    - SPA redirect uri: ```$APP_URL/.auth/login/aad/callback```
- Add authentication to container app and select existing aad auth app:
    - Issuer url: ```https://login.microsoftonline.com/$TENANT_ID/v2.0```