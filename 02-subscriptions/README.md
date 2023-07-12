# 02-subscriptions

## Before running terraform
Create the payg subscription on the portal and change its name to sub-bu1-app1-dev 

Github repositories to store infra, app-infra and app code exists. It could be just 1 repo like we have here.

Assign ```RoleManagement.ReadWrite.Directory``` role to ```sp-org-terraform``` and grant admin consent

Set env var for github provider ```export GITHUB_TOKEN=<classic personal access token>```

