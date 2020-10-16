## Ускорение клавиатуры 
**Set keybord speed**
```
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30   
gsettings set org.gnome.desktop.peripherals.keyboard delay 250    
```

## 9. ОТКЛЮЧИТЕ ОТЧЁТЫ О СБОЯХ
Если вы не собираетесь сообщать разработчикам о случившихся в системе ошибках и сбоях, отчёты о них можно отключить. Лучше, конечно, отправлять данные, особенно в бета-версии, - это поможет разработчикам исправить ошибки.
Для отключения всплывающих отчётов об ошибках запустите терминал и выполните:

```
sudo sed -i "s/enabled=1/enabled=0/g" '/etc/default/apport'
```
