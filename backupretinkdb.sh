#!/bin/bash


##########################################################################################################################################################################
# PRODUCTION 
# Архивное копирование базы данных RETHINKDB на сервер.
# Копирование базы данных на сервер архивации.
# Отправка сообщений по почте и запись в лог файле.
# Version 1.2.0 
# Date 21.01.2016 10:22-14:08
# 
# Копирование для  тестового сервера.
# 
# Примечания для ведения расписания:
# Для проверки создания файла на ftp необходимо рефреш каталога
# Расписание в кроне на основании другого файла с расписанием (10:40).
# 40 10 * * * /home/user1/backdb
#
# Управление кроном :
# Удалить все задания     : crontab -r
# Просомтреть все задания : crontab -l
# Откорректировать        : crontab -e
# 
# Особенность операции копирования :
# Старый файл будет перекрыт новым без предупреждения на удаленном сервере !!!
# 
# Важно  !
# Проверить и установить правильное время на сервере инче расписание будет неверным.
# 
# Установка даты из командной строки:        sudo date +%Y%m%d -s "20120418"
# Установка времени из командной строки:     sudo date +%T -s "11:14:00"
#
# Links :
# http://rus-linux.net/MyLDP/consol/time-date-v-konsoli.html  
# http://server-tuning.info/linux/setting-date-time.html
# http://unixa.ru/korotko-o-glavnom-./ustanovka-datyi-i-vremeni-v-konsoli.html
#
# Проконтролировать по адресу в браузере :
# ftp://backup:123456789@10.10.10.10/homes/user/back/
#
##########################################################################################################################################################################

clear 

# Определение переменных 
NOW=$(date +"%d-%m-%Y %T")                                                                       # Дата старта  $(date +"%d-%m-%Y %T %A") %A - День недели по английски
EMAIL="you@post.com"                                                                             # Адрес отсылки куда
FROM="from@fom.com"                                                                              # От кого послано сообщение
LOGFL="log.txt"                                                                                  # Имя файла для логирования операций
BAKFL="db.tar"                                                                                   # Имя архивного файла после архивации
NOTIF="Cообщение отправлено на почту."                                                           # Сообщение для лог опреаций 
FTPPT="ftp://bak:123456789@10.0.10.10/homes/prod/"                                               # Адрес получения архива на FTP сервер
ARCHP="/var/lib/rethinkdb/instance1/data"                                                        # Путь от куда будет копироваться информация
SEPAR="**************************************************************************************"   # Разделитель в лог файле
PASS="00$$$00"


# Путь к данным котрые будут добавлены в архив.
# ARCHP=~/db                                                                                     # из текущей директории в ~/DB  = "/home/user1/DB"
# ARCHP="/home/arthur/db"                                                                        # если прописывается вручную - в скобках
  ARCHP="/var/lib/rethinkdb/instance1/data"                                                      # Путь от куда будет копироваться информация

# Начало операции
echo "$SEPAR" >> $LOGFL

echo "$NOW  Старт копирования и перенос базы на сервер архивации." >> $LOGFL

NOWA=$(date +"%d-%m-%Y %T")

#  Архивация в базы данных в пользовательскую директорию
#  tar cvf $BAKFL $ARCHP 
    
#  Копирование основной базы	средствами rethinkdb
#  rethinkdb dump -c localhost -e System -a 000Morion000 -f System.tar.gz
  
#  rethinkdb dump -c localhost -e System -a $PASS -f $BAKFL
#  rethinkdb dump -c localhost -e System -f System.tar
#  curl -0 -T System.tar $FTPPT
#  rm System.tar
#  echo Копирование окончено System.
          
#  Остальные базы в отдельные файлы
#  rethinkdb dump -c localhost -e C10 -f C10.tar
#  curl -0 -T C10.tar $FTPPT
#  rm  C10.tar
#  echo С10 Окончено копирование.

#####################################################################
#
# Author   : Savchenko Arthur
# Function : Database Backup
# Datetime : 01.04.2016 10:00
# Update   : 31/05/2016 16:49
#
#####################################################################


bdb(){
      TIMECOPY=$(date +"%d-%m-%Y")
      rethinkdb dump -c localhost -e $2 -f $2".tar"
      curl -0 -T $2".tar" $1
      rm $2".tar"
      
      curl -XPOST http://ho.service.com.ua:5555/api/task/add/Скопировано%20$2*$TIMECOPY*BACK%20DB*0
      echo $TIMECOPY $2 Окончено копирование >>logcopy.log
}

# Копирование основных клиентов
copyvip(){
   #Копировать всегда 
   bdb $FTPPT "System"
   bdb $FTPPT "DB1"
   bdb $FTPPT "DB2"
   bdb $FTPPT "DB3"
   bdb $FTPPT "DB4"
   bdb $FTPPT "DB5"
   bdb $FTPPT "DB6"
   bdb $FTPPT "DB7"
}


######################################################################
# Copy Databases
# D:\WORK\corporation.xlsx
######################################################################

NNSTART=$(date +"%d-%m-%Y %T")

echo "----------------------------------------------------" >>logcopy.log
echo $NNSTART Старт сессии копирования >>logcopy.log

# Копирование баз 
copyvip

NNFINISH=$(date +"%d-%m-%Y %T")

echo Финиш: $NNFINISH  >>logcopy.log
echo "----------------------------------------------------------------------" >>logcopy.log
echo "" >>logcopy.log

# Посылка на почту сообщения
  NNFINISH=$(date +"%d-%m-%Y %T")
  echo -e "Архивирование основных таблиц. \nСтарт: $NNSTART. \nФиниш: $NNFINISH." | mail -s "Production server. Копирование базы на сервер." -r $FROM $EMAIL

  NWF=$(date +"%d-%m-%Y %T")
  echo -e "Копирование архива на сервер. \nCnfhn: $NWF. \nФиниш: $NOWS." | mail -s "Production. Эксеприментальное архивирование закончилось." -r $FROM $EMAIL
   
## После тестового испытания архивируем всю базу   
## rethinkdb dump -c localhost -a $PASS -f $BAKFL

# Окончание архивации
  NOW=$(date +"%d-%m-%Y %T")
  echo -e "Архивация базы данных.  \nСтарт: $NOWA. \nФиниш: $NOW." | mail -s "Production. Архивация базы." -r $FROM $EMAIL
  echo "$NOWA  Архивация окончена. $NOTIF" >> $LOGFL

# Начало передачи на сервер архивации
  NOWS=$(date +"%d-%m-%Y %T")
# curl -0 -T $BAKFL $FTPPT

NOWF=$(date +"%d-%m-%Y %T")
echo -e "Копирование архива на сервер. \nCnfhn: $NOW. \nФиниш: $NOWS." | mail -s "Production. Копирование базы на сервер." -r $FROM $EMAIL
echo "$NOWS  Копирование на сервер завршено. $NOTIF" >> $LOGFL

# Удаление файла после передачи на сервер архивации
# rm $BAKFL

# Сообщение об окончании операции
NOWB=$(date +"%d-%m-%Y %T")
echo "Операция архивного копирования завршена.\nСтарат: $NOWA. \nФиниш: $NOWB." | mail -s "Production. Окончание копирования." -r $FROM $EMAIL
echo "$NOWB  Исходная архивная копия удалена. $NOTIF" >> $LOGFL
echo "$SEPAR" >> $LOGFL

# Очистка памяти
/home/arthur/clcc
echo "Память очищена" | mail -s "Production. Очистка памяти." -r $FROM $EMAIL
