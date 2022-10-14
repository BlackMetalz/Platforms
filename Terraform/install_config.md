### For ubuntu/debian

```
apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && sudo apt-get install terraform
```

Other OS Ref: https://learn.hashicorp.com/tutorials/terraform/install-cli

- Step for setup

```
terraform init
terraform plan -out=/tmp/my_tf_plan 
terraform apply "/tmp/my_tf_plan"
```