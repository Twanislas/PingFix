@ECHO OFF
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Script réalisé par Antoine Rahier
:: v1.0 - 23 Juillet 2009
::
:: Ce script utilise l'algorithme de Nagle afin d'optimiser
:: vos connexions réseau.
:: Plus d'info : http://fr.wikipedia.org/wiki/Algorithme_de_Nagle
::
:: Vous êtes libre de le distribuer à votre guise, veuillez
:: simplement mentionner l'auteur original.
::
:: Si vous utilisez ce script et qu'il vous plaît, faites
:: le moi savoir en m'envoyant un mail : antoine.rahier@gmail.com
::
:: Merci ! :)
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

TITLE PingFix v1.0 (Installer)
:: On dit bonjour :)
ECHO.
ECHO Ping fix !
ECHO ===================
ECHO.
ECHO Applicaiton des modifications au registre...

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
>>%Temp%\add.reg ECHO "TCPNoDelay"=dword:00000001
>>%Temp%\add.reg ECHO.

:: On process le fichier temporaire
FOR /F "tokens=*" %%i IN ('TYPE %Temp%\tmp2.reg') DO CALL :Parse %%i

:: On pousse add.reg dans le registre
REGEDIT /S %Temp%\add.reg

:: On vire les fichiers temporaires
IF EXIST "%Temp%\tmp.reg" DEL "%Temp%\tmp.reg"
IF EXIST "%Temp%\tmp2.reg" DEL "%Temp%\tmp2.reg"
IF EXIST "%Temp%\add.reg" DEL "%Temp%\add.reg"

:: On dit au revoir :)
ECHO Travail termine !
ECHO Les modifications ne seront effectives qu'apres un redemarrage de la machine ;)
ECHO.
PAUSE
ENDLOCAL
GOTO:EOF

:Parse
:: On ajoute le TcpAckFrequecy a chaque sous clé
SET Key=%1
>>%Temp%\add.reg ECHO %Key%
>>%Temp%\add.reg ECHO "TcpAckFrequency"=dword:00000001
>>%Temp%\add.reg ECHO.
GOTO:EOF