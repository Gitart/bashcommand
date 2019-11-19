@echo off
SETLOCAL
:: start

rem Ïóòü ê ìîåé ïðîãðàììå
SET GOPATH=D:\ORION\RETHINKDB\GO

rem ïóòü ê êîìïèëÿòîðó
SET GOROOT=C:\GO
SET PATH=%GOROOT%\BIN;%PATH%;

CLS

title UPDATE RETHINKDB DRIVER
color 0f


go get -u "github.com/dancannon/gorethink" >> d:\morion\rethinkdb\go\bin\log_update.txt


echo %Date% %Time%  %date:~-10,2% UPDATE GO RETHINK DRIVER >> d:\morion\rethinkdb\go\bin\log_update.txt
cd d:\orion\rethinkdb\go\bin\

echo ......................................................................Ok Upadete
@pause
