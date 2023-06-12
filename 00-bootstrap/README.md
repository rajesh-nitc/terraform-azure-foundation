## 00-bootstrap

### Before running terraform

1. ```az login```

2. Create Service Principal with Owner [as we are learning!] role at ROOT. We will be running the code in local envioronment only and that is why not using user assigned identity

```
az ad sp create-for-rbac -n sp-org-terraform --role="Owner" --scopes="/"
```

3. ```az logout```

4. Set env vars for terraform:

```
export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
```

### Running terraform
First run with empty backend.tf
