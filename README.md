## vsvleo_infra
### Домашнее задание 05
#### Сквозное пдключение к инстансу internalhost, в одну строку:
```ssh -i ~/.ssh/appuser -A appuser@104.155.51.79 -t ssh 10.154.0.2 # connect in the one line```
#### Для создания алиаса, в каталоге пользователя редактируем файл: ~/.ssh/config
1. вариант _(с созданием дополнительного алиаса, для доступа на сервер bastion)_ :
```
Host bastion
    User appuser
    HostName 104.155.51.79

Host internalhost
    User appuser
    HostName 10.154.0.2
    IdentityFile ~/.ssh/appuser
    ProxyCommand ssh -W %h:%p bastion
 ```

2. вариант _(с помощью одного алиаса)_
```
Host internalhost
    User appuser
    HostName 10.154.0.2
    IdentityFile ~/.ssh/appuser
    ProxyCommand ssh -W %h:%p appuser@104.155.51.79
```
#### Создание VPN канала (OpenVPN)

**Инстанс bastion**
10.132.0.2 - Внутренний IP адрес
104.155.51.79 - внешний IP адрес
**Инстанс someinternalhost**
10.154.0.2 - внутренний IP адрес

Файлы:
```
krista\_test\_vpn-10855.ovpn - Файл конфигураций для создания клиента
setupvpn.sh - Скрипт для установки OpenVPN на GCP инстанс.
```

---

### Домашнее задание 06
#### Скрипт установки **ruby**
01. install_ruby.sh 
#### Скрипт установки **mongodb**
02. install_mongodb.sh
#### Скрипт скачивания и деплоя приложения
03. deploy.sh

---

### Домашнее задание 07
#### Шаблон для создания образа средствами packer
ubuntu16.json - шаблон с включенным переопределением переменных:
```
  "variables": {
    "proj_id": null,
    "family_image": null,
    "type_machines": "f1-micro"
  },
```
proj_id - переменная определяет ID проекта, по умолчанию не определена<br/>
family_image - семейство образов, так же не определена по умолчанию<br/>
type_machines - тип инстанса, здесь установлено значение по умолчанию: "f1-micro"<br/>

Запуск оссуществляется с обязательным указанием переменных proj-id и family_image
```
packer build -var "family_image=[имя семейства образов]" -var "proj_id=[ID проекта]" ubuntu16.json
```
При вынесении определения переменных в отдельный файл variables.json (в качестве примера указан файл variables.json.example), в параметрах запуска необходимо, по мимо самих переменных 
proj-id и family_image, так же указать и сам файл:
```
packer validate -var-file=variables.json -var "family_image=[имя семейства образов]" -var "proj_id=[ID проекта]" ubuntu16.json
```

---

### Домашнее задание 08
#### Создание инстанса при использовании terraform
Команды которые применялись при выполнении домашнего задания:
```
terraform init - загружает провайдер, указанный в файле main.tf
terraform plan - отображает планируемые изменения
terraform apply - Запускает инстанс или применяет изменения
        -auto-approve=true - вкючает автоматическое подтверждение запросов при выполнении
terrafom show - выводит все атрибуты из state файла.
terraform refresh - переопределение переменных с атрибутов state файла
terraform output - выводит список переменных и их значений или только значение указанной переменной
terraform taint [имя ресурса] - при применении изменений указанный ресурс будет пересоздан
terraform destroy - удаляет все ресурсы
terraform fmt - форматирование конфигурационных файлов
```
Описание созданных файлов:
```
main.tf - основной конфигурационный файл
output.tf - файл с описанием выходных переменных
variables.tf - файл с описанием входных переменных
terraform.tfvars - определение значений для переменных. в репозитории выложен пример файла terraform.tfvars.example
/files/deploy.sh - скрипт для установки и запуска приложения reddit
/files/puma.service - конфигурационный файл для инициализации приложения reddit
```
Для создания инстанса необходимо задать значения переменных в файле terraform.tfvars, в качестве примера 
можно посмотреть файл terraform.tfvars.exampe. Для понимания, какие переменные имеют дефолтные значения, 
но могут быть переопределены, можно посмотреть в файле variables.tf, значение default.<br/>
Следующим шагом будет инициализация провайдера коммандой terraform init и далее, непосредственно сам 
запуск инстанса terraform apply<br/>
Для выполнения вышеописанных команд должен быть скачен сам terraform https://www.terraform.io/downloads.html. 
Прописан путь до файла terraform. И все команды выполнять в папке с файлом main.tf

