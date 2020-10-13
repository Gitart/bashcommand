
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

# https://howtoinstall.co/en/ubuntu/xenial/docker?action=remove
echo Uninstall docker...
#To remove just docker package itself from Ubuntu 16.04 (Xenial Xerus) execute on terminal:

sudo apt-get remove docker

echo Uninstall docker and it's dependent packages
#sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
#To remove the docker package and any other dependant package which are no longer needed from Ubuntu Xenial.

sudo apt-get autoremove docker

echo Purging docker...

#If you also want to delete configuration and/or data files of docker from Ubuntu Xenial then this will work:

sudo apt-get purge docker

echo To delete configuration and/or data files of docker and it's dependencies from Ubuntu Xenial then execute:
sudo apt-get autoremove --purge docker  


Удалить из загрузки
# https://askubuntu.ru/questions/310531/otkljuchit-avtozapusk-docker-pri-zagruzke

# Отключение при загрузке
#https://askubuntu.ru/questions/310531/otkljuchit-avtozapusk-docker-pri-zagruzke
# https://qastack.ru/ubuntu/766318/disable-docker-autostart-at-boot
sudo systemctl disable docker.service
sudo systemctl disable docker.socket

# удалить из загрузки
sudo systemctl kill docker.service
sudo systemctl kill docker.socket


# Просомтр процесса
# systemctl list-unit-files | grep -i docker
# ps axf | grep docker  


# В моем случае пришлось отключить docker-volume-local-persist.serviceи docker.socketтак же. 
# Чтобы перечислить любую службу докера в systemd, введите:systemctl list-unit-files | grep -i docker
# Хорошо, я думаю, что мне удалось заставить его работать, после Как включить или отключить службы? :
# sudo bash -c 'echo manual | sudo tee /etc/init/docker.override'
