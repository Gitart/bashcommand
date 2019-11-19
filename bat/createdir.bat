set DD=%date:~0,2% 
set MM=%date:~3,2% 
set YY=%date:~8,2% 
set YYYY=%date:~6,4% 
set HH=%time:~0,2% 
set MN=%time:~3,2% 
set FOLDER=%YYYY%-%MM%-%DD% 



MD D:\RETHINKDB\service\back\%date:~6,4%-%date:~3,2%-%date:~0,2%-%HH%-%MN%
