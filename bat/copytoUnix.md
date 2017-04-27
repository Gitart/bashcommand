## Копирование между Windows & Unix


rem -P 22     port    
rem -l        user in windows system    
rem -pw       password    
rem *.go      mask    
rem user@...      

```
pscp.exe -P 22 -l savchenko -pw QWErty123  *.go  user@172.25.64.16:/home/user/report/1
```
