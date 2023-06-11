## 00-bootstrap

### Before running terraform

1. ```az login```

2. Create Service Principal with Owner [as we are learning!] role at ROOT:

```
az ad sp create-for-rbac -n sp-org-terraform --role="Owner" --scopes="/"
```

3. ```az logout```

4. Set env vars for terraform:

```
export ARM_CLIENT_ID="3d6f7501-31a3-44f3-aa83-bbd2ca107a2f"
export ARM_CLIENT_SECRET="WNM8Q~liVQzTiR4KoKqIr-T-gSqzzgrpu3Myucpd"
export ARM_SUBSCRIPTION_ID="8eba36d1-77ed-4614-9d23-ec86131e8315"
export ARM_TENANT_ID="fbae0f56-f901-41f2-8431-00d5dc38b1f4"
```

### Running terraform
Run it with empty backend.tf
