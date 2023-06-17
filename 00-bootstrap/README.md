## 00-bootstrap

### Before running terraform

1. ```az login```

2. Create Service Principal with Owner role at ROOT. We are not using the managed identity [yet!] as we are running the code manually in local environment.

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
5. Change the name of your pay as you subscription to bootstrap-tfstate

### Running terraform
First run with empty backend.tf
