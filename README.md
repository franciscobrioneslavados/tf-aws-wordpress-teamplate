# Getting Started

### Comands
```
terraform init
```

```
terraform plan -out tfplandev.out -var-file=environment/test.tfvars
```

```
terraform apply "tfplandev.out"
```

```
terraform destroy "tfplandev.out"
```


## SSH Connect Instance
```
chmod 400 <file_name>.pem
```
```
ssh -i "<file_name>.pem" ec2-user@<public_dns>
```