## ДЗ 14 - terraform yandex template

  - ## convert my terraform OAuth-token to IAM-token
  - sudo curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  - yc init
  - yc config list
  - ## prepare infrastructure
  - sudo apt update
  - sudo apt-get update
  - sudo apt-get install mc -y
  - sudo mc
  - apt install git
  - apt install unzip
  - ## install terraform
  - cd /tmp
  - git clone https://github.com/spring108/terraform.git
  - cd /tmp/terraform
  - unzip terraform_1.7.0_linux_amd64.zip
  - cp ./terraform /bin
  - terraform --version
  - ## load project
  - cd /home/igor
  - git clone https://github.com/spring108/terraform_yandex.git
  - cd /home/igor/terraform_yandex
  - ## setup my IAM-token into config.tf
  - terraform init
  - terraform plan
  - terraform apply


