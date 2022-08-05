# Getting Started
In order to quickly get started with the template the following steps need to be done:

* ssh-keygen -t rsa -b 4096 -C "franciscobrioneslavados@gmail.com" -f $PWD/id_rsa
* ssh-keygen -f id_rsa.pub -m 'PEM' -e > id_rsa.pub.pem


### Comands
```
terraform init
```

```
terraform plan 
```

```
terraform apply --auto-approve
```

```
terraform destroy --auto-approve
```
