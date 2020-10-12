
# https://qastack.ru/ubuntu/935569/how-to-completely-uninstall-docker
#Шаг 1

dpkg -l | grep -i docker

#Чтобы определить, какой установленный у вас пакет:

#Шаг 2

#sudo apt-get purge -y docker-engine docker docker.io docker-ce
#sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
#Приведенные выше команды не будут удалять изображения, контейнеры, тома или созданные пользователем файлы конфигурации на вашем хосте.
#Если вы хотите удалить все изображения, контейнеры и тома, выполните следующие команды:

sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
