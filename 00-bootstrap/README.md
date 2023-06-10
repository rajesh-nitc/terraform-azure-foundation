## 00-bootstrap

az login
az account set --subscription "8eba36d1-77ed-4614-9d23-ec86131e8315"
az ad sp create-for-rbac -n sp-org-terraform --role="Owner" --scopes="/subscriptions/8eba36d1-77ed-4614-9d23-ec86131e8315"