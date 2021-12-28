# gaming
leisure suit harry

currently using parsec. works pretty well.

other options:
* nice dcv (strange mouse input)
* moonlight (configure sunshine server on instance)

## from scratch
* setup remote state bucket, dynamo lock table and your ssh public key
* `terraform init && terraform apply -auto-approve`
* login with ms rdp (wait 4m && get password from ec2 aws console)
* run `iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/tomgrice/g5-cloudrig/main/Start.ps1'))`
* reboot
* run parsec cloud prep script (w/o gpu driver installation) (https://github.com/parsec-cloud/Parsec-Cloud-Preparation-Tool)
  ```
  [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
  $ScriptWebArchive = "https://github.com/parsec-cloud/Parsec-Cloud-Preparation-Tool/archive/master.zip"  
  $LocalArchivePath = "$ENV:UserProfile\Downloads\Parsec-Cloud-Preparation-Tool"  
  (New-Object System.Net.WebClient).DownloadFile($ScriptWebArchive, "$LocalArchivePath.zip")  
  Expand-Archive "$LocalArchivePath.zip" -DestinationPath $LocalArchivePath -Force  
  CD $LocalArchivePath\Parsec-Cloud-Preparation-Tool-master\PostInstall
  powershell.exe .\PostInstall.ps1 -DontPromptPasswordUpdateGPU
  ``` 

## backup
```shell
cd backup
terraform init && terraform apply -auto-approve
```

## credits
* https://github.com/carterjones/infrastructure
* https://github.com/tomgrice/g5-cloudrig
* https://github.com/parsec-cloud/Parsec-Cloud-Preparation-Tool
* https://github.com/aws-samples/cloud-gaming-on-ec2-instances
* https://github.com/debanjanbasu/instant-instance
