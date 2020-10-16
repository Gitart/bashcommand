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


[By material](https://losst.ru/nastrojka-ubuntu-16-04-posle-ustanovki#6_%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%B8%D1%82%D0%B5_Ubuntu_Tweak_Tool_%D0%B4%D0%BB%D1%8F_%D0%BD%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B9%D0%BA%D0%B8_%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%8B)
