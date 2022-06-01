echo off@
cd sklad

rem ghи ошибке - git error: failed to push some refs to remote
rem git pull --rebase origin main
rem git push origin main

rem Get date + time mark
rem При расчете позиций в дате и времени точка не учитывается 
set YYYYMMDD=%DATE:~0,2%%DATE:~3,2%%DATE:~6,4%
set tm=%TIME:~0,2%%TIME:~3,2%
set tms=%YYYYMMDD%%tm%

cls
git pull origin
git add -A
git commit -a -m "%tms% : Fix and update - Add sql for creted database "
git push origin main

echo Completed...
pause 

