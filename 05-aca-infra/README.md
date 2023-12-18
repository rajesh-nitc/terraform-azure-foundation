# aca-infra

Apim api is not created as part of terraform

After ```api``` is deployed via github workflow:
 - Manually import it into apim using OpenAPI specification. As we are using fastapi, openapi spec is available at https://api_url/openapi.json. API URL suffix is important, let's give it a value of api. Choose the product created as part of terraform
 - Manually update the ```aca_web.yaml``` workflow with ```REACT_APP_APIM_URL```. Append it with API URL suffix which is set as api

Update inbound policy of api to allow cors:
```
<inbound>
        <cors allow-credentials="true"> 
            <allowed-origins> 
                <origin>the origin url of web app</origin> 
            </allowed-origins> 
            <allowed-methods preflight-result-max-age="300"> 
                <method>*</method> 
            </allowed-methods> 
            <allowed-headers> 
                <header>*</header> 
            </allowed-headers> 
            <expose-headers> 
            <header>*</header> 
            </expose-headers> 
        </cors> 
    </inbound>
```