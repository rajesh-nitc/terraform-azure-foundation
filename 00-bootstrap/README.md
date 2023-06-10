## 00-bootstrap

### Before running terraform

1. ```az login```

2. Create Service Principal with Owner role at ROOT:

```
az ad sp create-for-rbac -n sp-org-terraform --role="Owner" --scopes="/"
```

3. ```az logout```

4. Set env vars for terraform:

```
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
```

### After running terraform