## Копирование папки с содержимым

```bat
@echo off
color 3f
title Копирование папки с содержимым
rem Timeout /t 120 /nobreak >nul

net use x: \\10.10.11.38\rep\tmp /persistent:no /user:Username Passwordsecret
xcopy "d:\work\prg\report\tmp\*.*" "x:\" /s /e /h /y
net use  x: /delete 

rem echo Ok
rem pause
```
