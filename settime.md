## Для правильного отображения даты на сервере UBUNTU  
Необходимо установить правильно временную зону.

```bash
sudo timedatectl set-timezone Europe/Kiev
```

Отображение всех временных зон
```bash
timedatectl list-timezone
```

Для отправки почты необходимо установить
```bash
sudo apt install mail
```

Команда для отправки почты
```
echo -e "Тело сообщения." | mail -s "Сообщение" -r "robot@system.ua" "destination@post.com"
```

