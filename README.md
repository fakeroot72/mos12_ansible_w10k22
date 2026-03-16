# Автоматическое конфигурирование ПК под управлением М ОС 12 для ГБОУ Школа № 1580

## Установка

```
rm -rf /opt/.lycu1580v2/
dnf -y update
dnf -y install ansible git cronie
ansible-pull -d /opt/.lycu1580v2/ -U https://hub.mos.ru/1580/mos12_ansible_w10k22.git 
reboot
```

Все команды в отду строку:
```
rm -rf /opt/.lycu1580v2/; dnf -y update && dnf -y install ansible git cronie && ansible-pull -d /opt/.lycu1580v2/ -U https://hub.mos.ru/1580/mos12_ansible_w10k22.git && reboot
```

Команды собраны в файле [install.sh](https://hub.mos.ru/1580/mos12_ansible_w10k22/-/blob/main/docs/install.sh)

Для скачивания можно использовать команду:
```
wget https://hub.mos.ru/1580/mos12_ansible_w10k22/-/raw/main/docs/install.sh?inline=false
```

Для запуска необходимо ввести:
```
sudo sh install.sh
```

Будет запрошен пароль для `sudo`.

## Разворачиваемая инфраструктура

- Пользователь student с паролем 1580:
  - настроен автологин;
  - при загрузке компьютера очищается домашняя папка, её резервная копия доступна под учительским логином в течении текущего календарного дня, потом она удаляется.
- Создание пользователя teacher (пароль высылается по запросу).
- Устанавливатся программного обеспечение:
  - Программирование (для всех языков)
    - Geany
    - Visual Studio Code
  - Программирование на Python
    - IDLE
    - Wing 101
    - Wing Personal
    - PyCharm Community Edition
  - Программирование на C++
    - Code::Blocks
    - Qt Creator
    - GNU Compiler Collection
    - GNU Debugger
  - Программирование на Pascal
    - Free Pascal
    - Lazarus
    - PascalABC.NET
  - Программирование (другие языки)
    - Go Programming Language
    - Rust Programming Language
    - Scratch
    - Processing 
    - Java
    - IntelliJ IDEA
  - Другие программы
    - Vim
    - Open Broadcaster Software - OBS Studio
    - Oracle VM VirtualBox
    - Gromit
  - Электроника и робототехника
      - Arduino IDE
      - TRIK Studio
  - 3D моделирование
    - T-FLEX CAD 17 Учебная версия
    - Компас 3D LT
    - Blender
  
## Контакты

По вопросам, связанным с этим проектом, пишите на электронную почту ALobachev@1580.ru

## Дополнительные ресурсы

При создании данного репозтория много информации было получено с сайтов:
- https://wiki.dno-it.ru/
- https://it-help-school.ru/
- https://fsen.ru/linux/tune
