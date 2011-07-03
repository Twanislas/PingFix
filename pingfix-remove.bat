@ECHO OFF
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Copyright 2009-2011 Antoine Rahier
:: This file is part of PingFix.
:: 
:: PingFix is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: Foobar is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
:: 
:: You should have received a copy of the GNU General Public License
:: along with PingFix.  If not, see <http://www.gnu.org/licenses/>.
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

TITLE PingFix v1.1 (Remover)
:: On dit bonjour :)
ECHO.
ECHO PingFix !
ECHO ==========
ECHO.
ECHO Preparing modifications...

:: Toutes nos variables sont locales
SETLOCAL

:: On lit le registre pour avoir les infos dont on a besoin
REGEDIT /E %Temp%\tmp.reg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\"

:: On vire ce dont on a pas besoin
TYPE %Temp%\tmp.reg | FIND "{" > %Temp%\tmp2.reg

:: On prépare add.reg
>%Temp%\add.reg ECHO Windows Registry Editor Version 5.00
>>%Temp%\add.reg ECHO.
>>%Temp%\add.reg ECHO [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters]
>>%Temp%\add.reg ECHO "TCPNoDelay"=-
>>%Temp%\add.reg ECHO.

:: On process le fichier temporaire
FOR /F "tokens=*" %%i IN ('TYPE %Temp%\tmp2.reg') DO CALL :Parse %%i

ECHO Applying modifications...

:: On pousse add.reg dans le registre
REGEDIT /S %Temp%\add.reg

ECHO Cleaning up...

:: On vire les fichiers temporaires
IF EXIST "%Temp%\tmp.reg" DEL "%Temp%\tmp.reg"
IF EXIST "%Temp%\tmp2.reg" DEL "%Temp%\tmp2.reg"
IF EXIST "%Temp%\add.reg" DEL "%Temp%\add.reg"

:: On dit au revoir :)
ECHO Done !
ECHO Modifications will apply after a reboot ;)
ECHO.
PAUSE
ENDLOCAL
GOTO:EOF

:Parse
:: On enlèvee le TcpAckFrequecy de chaque sous clé
SET Key=%1
>>%Temp%\add.reg ECHO %Key%
>>%Temp%\add.reg ECHO "TcpAckFrequency"=-
>>%Temp%\add.reg ECHO.
GOTO:EOF