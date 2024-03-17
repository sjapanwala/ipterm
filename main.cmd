@echo off
chcp 65001>nul
::color variables
set brightred=[40;91m
set brightyellow=[40;93m
set brightgreen=[40;92m
set brightblue=[40;94m
set brightpurple=[40;95m
set brightcyan=[40;96m
set brightwhite=[40;97m
set darkred=[40;31m
set darkyellow=[40;33m
set darkgreen=[40;32m
set darkblue=[40;34m
set darkpurple=[40;35m
set darkcyan=[40;36m
set white=[40;37m
::---function vars
::terminal settings
set tversion=0.1
set ttheme=Original
set shell=Windows
for /f "tokens=2 delims==" %%b in ('wmic csproduct get Vendor /value') do set host=%%b
for /f "tokens=2 delims==" %%c in ('wmic os get caption /value ^| findstr "=" ') do set OS=%%c
for /f "tokens=2 delims==" %%d in ('wmic cpu get name /value ^| findstr "=" ') do set CPU=%%d
:: ip func
set targetip=none
set iptype=IPV4
:: userfunc
set userpermission=user
set safetydomain=8.8.8.8
set termusername=%username%
set askpwd=True
set displaynotifs=True
::display func
set targetipdisplay=%darkred%%targetip%%brightwhite%
set iptypedisplay=%brightgreen%%iptype%%brightwhite%
::curl vars
FOR /F %%a IN ('curl https://ipv4.icanhazip.com/') DO set localip=%%a
:startup
cls
if not %displaynotifs%==True goto commandline
if exist warns\.install_file echo %white%🪧 Please Install Files For Full Access
:commandline
echo %brightwhite%
echo ┌──(%brightred%%termusername%%brightwhite%@%brightred%%computername%%brightwhite%)-[%iptype%][%brightpurple%%targetip%%brightwhite%]
set /p command=└─%brightred%!%brightwhite%
:: general commands
if "%command%"=="help" goto help
if "%command%"=="help-a" goto allhelp
if "%command%"=="cls" goto startup
if "%command%"=="clear" goto startup
if "%command%"=="swusr" goto switchuser
if "%command%"=="info" goto info
::root
if "%command%"=="root-h" goto roothelp
if "%command%"=="root-plant" goto plant
:: insert command
if "%command%"=="insert-h" goto inserthelp
if "%command%"=="insert-ip" goto insertip
if "%command%"=="insert-api" goto apikey

:: ipdisplay
if "%command%"=="ipdisplay-h" goto ipdisplayhelp
if "%command%"=="ipdisplay-l" goto ipdisplaylocal
if "%command%"=="ipdisplay-t" goto ipdisplaytarget
if "%command%"=="ipdisplay-t2" goto ipdisplaytarget2

::communicate

:: send packets
if "%command%"=="ping-t" goto pingtarget
if "%command%"=="ping-h" goto pinghelp
if "%command%"=="ping-tb" goto pingbare

::test
if "%command%"=="test-h" goto testhelp
if "%command%"=="test-net" goto testnet


::geo

::whois

:: connectpath
if "%command%"=="tracepath-h" goto connecthelp
if "%command%"=="tracepath-t" goto connectpathtarget
if "%command%"=="tracepath-web" goto connectpathweb

::matrix

goto invalidcommand

:invalidcommand
echo.
echo %white%Command '%command%' not found, Try help or (command)-h
echo.
goto commandline


:help
echo.
echo ╔General Help
echo ╚:Shows general help
echo.
echo help :--: shows this page
echo help-a :: shows all help
echo cls :---: clears screen
echo plant :-: plants file into C:\Users\%username%
echo swusr :-: switches user
echo info :--: shows information
echo. 
echo For Command Help, Type "(commandname)-h"
echo.
goto commandline


:switchuser
echo.
echo User Profiles Available.
echo.
echo 1) %username%
echo 2) root
echo.
set /p choice=: 
if %choice%==1 goto localuser
if %choice%==2 goto rootuser
echo.
goto commandline
:localuser
echo.
set userpermission=user
set termusername=%username%
echo %brightgreen%Successfully Logged Into %username%%brightwhite%
echo.
goto commandline
:rootuser
echo username: root
set /p pwd=password: 
if "%pwd%"=="root" goto rootlogin
echo %brightred%Incorrect Password Detected%brightwhite%
echo.
goto commandline
:rootlogin
set userpermission=root
set termusername=root
echo %brightgreen%Successfully Logged Into Root%brightwhite%
echo.
goto commandline
:roothelp
if not %userpermission%==root echo %brightred%User Permission Is Not Allowed%brightwhite% && goto commandline
echo.
echo ╔Root User Help
echo ╚:Mostly Config Commands
echo.
goto commandline


:info
echo General Information
echo.
echo %brightwhite%Current User :------: %darkred%%termusername%
echo %brightwhite%User Permissions :--: %darkred%%userpermission%
echo %brightwhite%Local IP :----------: %darkred%%localip%
echo %brightwhite%IP Type :-----------: %darkred%%iptype%
echo %brightwhite%Available IP Type :-: %darkred%IPV4,IPV6
echo %brightwhite%Local Domain :------: %darkred%%userdomain%
echo %brightwhite%Safety Domain :-----: %darkred%%safetydomain%
echo.
echo %brightwhite%Terminal Information
echo.
echo %brightwhite%Version :-----------: %darkred%%tversion%
echo %brightwhite%Theme :-------------: %darkred%%ttheme%
echo %brightwhite%CommandLine :-------: %darkred%%shell%
echo %brightwhite%Host :--------------: %darkred%%host%
echo %brightwhite%Host CPU :----------: %darkred%%CPU%
echo %brightwhite%Host OS :-----------: %darkred%%OS%
echo.
goto commandline

:plant
if not %userpermission%==root echo %brightred%User Permission Is Not Allowed%brightwhite% && goto commandline

:inserthelp
echo.
echo ╔Insert Help
echo ╚:Inserts data into the terminal depending on arguments
echo.
echo insert-h :--: shows insert help screen
echo insert-ip :-: able to insert target ip
echo insert-api :: insert an API Key.
echo.
goto commandline
:insertip
echo.
echo ┌(%brightred%%targetip%%brightwhite%)
set /p newip=└[Enter New IP]:
echo ╔═══════════════IP Connection═════════════════╗
curl http://ip-api.com/line/%newip%?fields=query
curl http://ip-api.com/line/%newip%?fields=status
curl http://ip-api.com/line/%newip%?fields=message
curl http://ip-api.com/line/%newip%?fields=org
echo ╚═════════════════════════════════════════════╝
echo.
if %newip%==%safetydomain% echo %brightyellow%⚠️!: TEMP-TARGET IP AND SAFETY DOMAIN MATCH %brightwhite%
set /p choice=Set %newip% as Target IP? (Y/N): 
if %choice%==y goto settarget
if %choice%==Y goto settarget
if %choice%==N echo %brightyellow%IP Set Abborted && goto commandline
if %choice%==n echo %brightyellow%IP Set Abborted && goto commandline
:settarget
set targetip=%newip%
echo %brightgreen%%newip% Has Been Set As New Target%white%
echo.
goto commandline

:apikey
echo ┌(%brightred%%apikey%%brightwhite%)
set /p apikey=└[Enter An API Key]:
echo.
echo Status
echo.
echo %brightyellow%Contacting Server
timeout 3 >nul
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %brightgreen% Server Connected %brightwhite%
echo  Testing API Key (1)
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %brightred% Test Failed %brightwhite%
echo  Testing API Key (2)
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %brightred% Test Failed %brightwhite%
echo  Testing API Key (3)
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %brightred% Test Failed %brightwhite%
echo  Test Fail Limit Reached
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %brightred% Server Rejected %brightwhite%
echo.
echo API Key Invalid, Double-Check Key and/or Try Again!
echo.
goto commandline


:ipdisplayhelp
echo.
echo ╔IP Display Help
echo ╚:Displays IP information depending on arguments
echo.
echo ipdisplay-h :--: shows ip help screen
echo ipdisplay-l :--: shows local ip information
echo ipdisplay-t :--: shows targetip information (branch-one)
echo ipdisplay-t2 :-: shows targetip information (branch-two)
echo.
goto commandline
:ipdisplaylocal
echo.
curl http://ip-api.com/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,mobile,proxy,hosting,query
echo.
goto commandline
:ipdisplaytarget2
echo.
if %targetip%==none echo %brightred% No IP Set, Please Set A Target IP First%brightwhite% && goto commandline
echo %brightcyan%
curl http://ip-api.com/line/?fields=%targetip%,status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query
echo.
goto commandline
:ipdisplaytarget
if %targetip%==none echo %brightred% No IP Set, Please Set A Target IP First%brightwhite% && goto commandline
echo.
echo %white% Note: this branch may not provide stable information, if you get an error, please try %brightgreen%"ipdisplay-t"%white%
echo %white% Note: to resole this issue, please provide a valid API key, %brightgreen%"insert-api"
echo.
echo %brightcyan%
curl https://ipapi.co/%targetip%/json/
echo.
goto commandline

:connecthelp
echo.
echo ╔Trace Path
echo ╚:Shows a route of connection paths from the initail connection to the final connection
echo.
echo tracepath-h :----: shows this help menu
echo tracepath-t :----: traces the target ip as final connection
echo tracepath-web :--: allows for a web connection as final connection
echo.
goto commandline
:connectpathtarget
if %targetip%==none echo %brightred% No IP Set, Please Set A Target IP First%brightwhite% && goto commandline
echo.
echo %brightcyan%
tracert %targetip%
goto commandline
:connectpathweb
set /p web=Please Enter A Web Name: 
echo.
echo %brightcyan%
tracert %web%
echo.
goto commandline

:pinghelp
echo.
echo ╔Ping Help
echo ╚:Sends/Pings to a network or IP given.
echo.
echo ping-h :----: shows this help menu
echo ping-t :----: pings the target IP
echo ping-tb :---: pings the target IP, feeds RAW data
echo.
goto commandline

:pingtarget
if %targetip%==none echo %brightred% No IP Set, Please Set A Target IP First%brightwhite% && goto commandline
echo %white% Note: You Are Connecting To Another Server, Please Be Cautious.
echo.
:targetlen
set /p targetlen=%brightwhite%Please Enter How Many Pings You Want To Send: 
if %targetlen% gtr 100 goto lenchoice
goto continuelen
:lenchoice
echo.
set /p choice=%brightyellow%⚠️: You are sending greater than a 100 packets, Continue? (Y/N): 
if %choice%==y goto continuelen
if %choice%==Y goto continuelen
if %choice%==N echo %brightyellow%Ping Set Abborted && goto commandline
if %choice%==n echo %brightyellow%Ping Set Abborted && goto commandline
goto lenchoice
:continuelen
set pingip= %targetip%
timeout 2 >nul
goto STARTPING
:STARTPING
set counter=0
:pmain
set /a counter+=1
set connectionlevel=OK
PING -n 1 %pingip% | FIND "TTL=">nul && echo [40;31m-$-[40;37mREPLY FROM [[40;32m%pingip%[40;37m] │ Connection [[40;33m%connectionlevel%[40;37m] │ Packet Loss: [40;32mNONE[40;37m │ Sending Signals: [40;32mTRUE[40;37m │ Recieving Signal: [40;32mTRUE[40;37m && set connectdata=CONNECTED, DATA SENT:%pingip%
IF ERRORLEVEL 1 (SET in=0b & echo [40;31mConnection Dead.) && echo Connection Lost or Terminated. && goto commandline
ping -t 2 0 10 127.0.0.1 >nul 
if %targetlen%==%counter% goto commandline
goto pmain

:pingbare
if %targetip%==none echo %brightred% No IP Set, Please Set A Target IP First%brightwhite% && goto commandline
echo %white% Note: You Are Connecting To Another Server, Please Be Cautious.
echo %white% Note: This is Ping Bare
echo.
:targetlen2
set /p targetlen=%brightwhite%Please Enter How Many Pings You Want To Send: 
if %targetlen% gtr 100 goto lenchoice2
goto continuelen2
:lenchoice2
echo.
set /p choice=%brightyellow%⚠️: You are sending greater than a 100 packets, Continue? (Y/N): 
if %choice%==y goto continuelen2
if %choice%==Y goto continuelen2
if %choice%==N echo %brightyellow%Ping Set Abborted && goto commandline
if %choice%==n echo %brightyellow%Ping Set Abborted && goto commandline
goto lenchoice2
:continuelen2
set pingip= %targetip%
timeout 2 >nul
goto STARTPING2
:STARTPING2
set counter=0
:pmain2
set /a counter+=1
echo %brightcyan%
PING -n 1 %pingip%
echo.
IF ERRORLEVEL 1 (SET in=0b && echo %brightyellow%Connection Lost or Terminated. ) && goto commandline
ping -t 2 0 10 127.0.0.1 >nul 
if %targetlen%==%counter% goto commandline
goto pmain2

:testhelp
echo.
echo ╔Test Help
echo ╚:Tests Various Functions
echo.
echo test-h :----: shows this help menu
echo test-net :--: tests hosts network connection
echo.
goto commandline
:testnet
echo.
set net=%localip%
echo %brightwhite%Network in Question -  %brightgreen%%net%
echo %brightyellow%Setting Up Ports
timeout 1 >nul
echo %brightyellow%Launching Test File
timeout 1 >nul
echo %brightyellow%Establishing Connection
timeout 1 >nul
echo.
echo.
PING -n 1 %net% | FIND "TTL=">nul && echo %brightwhite%Connection: %brightgreen%Great&& goto commandline
IF ERRORLEVEL 1 (SET in=0b & echo %brightwhite%Connection: %brightred%No Network Connected/No Signals) &&  goto commandline
