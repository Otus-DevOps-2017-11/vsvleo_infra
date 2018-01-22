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
**krista\_test\_vpn-10855.ovpn** - Файл конфигураций для создания клиента
**setupvpn.sh** - Скрипт для установки OpenVPN на GCP инстанс.

---

### Домашнее задание 06
#### Скрипт установки **ruby**
01. install_ruby.sh 
#### Скрипт установки **mongodb**
02. install_mongodb.sh
#### Скрипт скачивания и деплоя приложения
03. deploy.sh
