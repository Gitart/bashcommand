## Для правильного отображения даты на сервере UBUNTU  
Необходимо установить правильно временную зону на сервере.

```bash
sudo timedatectl set-timezone Europe/Kiev
```

Отображение всех временных зон
```bash
timedatectl list-timezone
```


-- Preview 
```bash
timedatectl list-timezones
```

-- setting
```
sudo timedatectl set-timezone Europe/Kyiv
```

-- Preview
```
timedatectl
timedatectl set-time 21:45:53
timedatectl set-time 2019-04-10
timedatectl list-timezones
```

// https://phoenixnap.com/kb/how-to-set-or-change-timezone-date-time-ubuntu

```
timedatectl list-timezones | grep Kyev
```

```
timedatectl set-ntp yes

timedatectl set-ntp no

-- set time
timedatectl set-time 21:45:53
```




Для отправки почты необходимо установить
```bash
sudo apt install mail
```

Команда для отправки почты
```bash
  #!/bin/bash
  
  NOW=$(date +"%d-%m-%Y %T") 
  echo -e "Тело сообщения." | mail -s "Сообщение" -r "robot@system.ua" "destination@post.com"
  echo $NOW $(date) $(hostname) 'Отправлено письмо $1' >> log.txt
```

