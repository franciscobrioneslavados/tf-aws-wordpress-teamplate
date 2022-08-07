# Getting Started

### Comands
```
terraform init
```

```
terraform plan -var-file=environment/test.tfvars
```

```
terraform apply --auto-approve -var-file=environment/test.tfvars
```

```
terraform destroy --auto-approve -var-file=environment/test.tfvars
```


## SSH Connect Instance
```
chmod 400 <file_name>.pem
```
```
ssh -i "<file_name>.pem" ec2-user@<public_dns>
```