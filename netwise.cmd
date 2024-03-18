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
::update functions
set currentfilename=%~n0%~x0
::if %currentfilename%==netwise.bat if exist netwise.cmd start netwise.cmd && del netwise.bat
::if %currentfilename%==netwise.cmd if exist netwise.bat start netwise.bat && del netwise.cmd
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
set targetdir=C:\Users\%username%
set countercool=False
set banned=False
set banstatus=UnBanned
if exist .config\netwise\.banned set banned=True
set banreason=SpamBot
title NetWise📍
::curl vars
FOR /F %%a IN ('curl -s https://ipv4.icanhazip.com/') DO set localip=%%a
:startup
cls
if %banned%==True goto banned
if not %displaynotifs%==True goto commandline
if not %cd% == %targetdir% set direrror=True && goto plantnoti
goto commandline
:plantnoti
echo ┌─(%brightblue%Please Plant This File Into %brightgreen%%targetdir%%brightblue% For Full Functionality)%white%
echo │
echo ├─'%white%Use "%brightgreen%root-plant%white%" as root user to plant this file'
echo └─'%white%Plant this file to not show this message again, or type "%brightgreen%disable-notif%white%" to temporarily disable this message'
if %countercool%==True echo %brightyellow%⚠️: Please Refrain From Using IP Services %brightgreen%For 5 Minuites%brightyellow% In Order To Prevent Being Banned
:commandline
echo %brightwhite%
echo ┌───(%brightred%%termusername%%brightwhite%@%brightred%%computername%%brightwhite%)-[%brightpurple%%targetip%%brightwhite%]
set /p command=└─%brightred%!%brightwhite%
:: general commands
if "%command%"=="docu" goto docu
if "%command%"=="exit" exit
if "%command%"=="comstruc" goto comstruc
if "%command%"=="readme" start https://github.com/sjapanwala/netwise && goto commandline
if "%command%"=="credit" start https://github.com/sjapanwala && goto commandline
if "%command%"=="help" goto help
if "%command%"=="help-a" goto allhelp
if "%command%"=="cls" goto startup
if "%command%"=="clear" goto startup
if "%command%"=="swusr" goto switchuser
if "%command%"=="info" goto info
if "%command%"=="relaunch" start %currentfilename% && exit
if "%command%"=="comstruc" goto comstruc



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

:: send packets
if "%command%"=="ping-t" goto pingtarget
if "%command%"=="ping-h" goto pinghelp
if "%command%"=="ping-tb" goto pingbare

::test
if "%command%"=="test-h" goto testhelp
if "%command%"=="test-net" goto testnet
if "%command%"=="test-cl" set countercool=True && goto startup
if "%command%"=="test-ban" goto banusr
if "%command%"=="test-unban" del .config\netwise\.banned && goto startup

:: disable
if "%command%"=="dis-h" goto disablehelp
if "%command%"=="dis-notif" goto disablenotif


::generateip
if "%command%"=="genip-h" goto geniphelp
if "%command%"=="genip-create" goto genip
if "%command%"=="genip-loop" goto geniploop

::geo

::whois

:: connectpath
if "%command%"=="tracepath-h" goto connecthelp
if "%command%"=="tracepath-t" goto connectpathtarget
if "%command%"=="tracepath-web" goto connectpathweb

::update
if "%command%"=="update-h" goto updatehelp
if "%command%"=="update-a" goto updateall
if "%command%"=="update-r" goto updatepackets



goto invalidcommand

:invalidcommand
echo.
echo %white%Command '%command%' not found, Try help or Try "%command%-h"
goto commandline


:banned
if %banned%==True set banstatus=Banned
echo ❌: %brightred%%username% Has Been IP Banned (%localip%), Please Wait Until Ban Period Is Over [%banreason%]
set /p bypass=└─(
if "%bypass%"=="swusr/root" (
    goto switchuser
) else (
    if "%bypass%"=="" (
        REM Handle empty input
        echo ~
    )
    goto banned
)


:banusr
echo %username% Is Banned>.banned
md .config
md netwise
move .banned netwise
move netwise .config
if exist .config\netwise\.banned set banned=True
goto startup

:help
echo.
echo ╔General Help
echo ╚:Shows general help
echo.
echo docu :--: shows documentation
echo readme :: redirects to the program github/readme
echo help :--: shows this page
echo help-a :: shows all help
echo cls :---: clears screen
echo plant :-: plants file into C:\Users\%username%
echo swusr :-: switches user
echo info :--: shows information
echo exit :--: exits a program
echo. 
echo For Command Help, Type "(commandname)-h"
echo.
goto commandline
:allhelp
echo.
echo [%brightred%*%brightwhite%] General Help   [%brightred%*%brightwhite%] Root Help   [%brightred%*%brightwhite%] Insert Help   [%brightred%*%brightwhite%] IP Display Help    [%brightred%*%brightwhite%] Ping Help
echo ├─ help            ├─ root-h       ├─ insert-h       ├─ ipdisplay-h         ├─ ping-h 
echo ├─ help-a          ├─ root-plant   ├─ insert-ip      ├─ ipdisplay-t         ├─ ping-t 
echo ├─ docu                            ├─ insert-api     ├─ ipdisplay-t2        ├─ ping-tb 
echo ├─ readme                                            ├─ ipdisplay-l 
echo ├─ cls/clear 
echo ├─ swusr 
echo ├─ info 
echo ├─ relaunch 
echo ├─ comstruc 
echo ├─ credit 
echo.
echo [%brightred%*%brightwhite%] Testing Help   [%brightred%*%brightwhite%] Dis Help    [%brightred%*%brightwhite%] Generate IP   [%brightred%*%brightwhite%] TracePath Help     [%brightred%*%brightwhite%] Update Help
echo ├─ test-h          ├─ dis-h        ├─ genip-h        ├─ tracepath-h         ├─ update-h 
echo ├─ test-net        ├─ dis-notif    ├─ genip-create   ├─ tracepath-t         ├─ update-a 
echo ├─ test-cl                         ├─ genip-loop     ├─ tracepath-web       ├─ update-r
echo ├─ test-ban 
echo ├─ test-unban 
echo.
echo For More Details About a Command, Enter "%brightgreen%(commandname)-h%brightwhite%"
goto commandline

:comstruc
echo.
echo %white%Structure of A Command,
echo %white%[%brightred%!%white%] - Every Command Must Follow LowerCase Unless Specified.
echo %white%[%brightred%!%white%] - Every Command Must Have An Arguement After The Main Command Unless Specified.
echo %white%[%brightred%!%white%] - Some Commands May Alter State, Please Remember Previous States or Save States
goto commandline

:docu
echo.
echo %brightwhite%Welcome to %brightred%NetWise%brightwhite%
echo.
echo - ReadMe File (https://shorturl.at/uAIMO)
echo %white%Note: if link cannot be clicked, type "%brightgreen%readme%brightwhite%" to access readme
echo.
echo Summary,
echo NetWise is a terminal based program that utilizes API's, Windows Commands and, many self made programs that
echo can assist with whatever network aid you desire! Commands can be accessed from the ReadMe File from github ("%brightgreen%readme%brightwhite%")
echo or type "%white%(commandname)-h%brightwhite%" for help with a command, if you already know the command but need help with parameters.
goto commandline

:switchuser
echo.
echo User Profiles Available.
echo.
echo [1] %username%
echo [2] root
echo.
set /p choice=: 
if %choice%==1 goto localuser
if %choice%==2 goto rootuser
echo.
goto commandline
:localuser
if %banned%==True goto banned
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
if %banned%==True goto startup
echo.
goto commandline
:rootlogin
set userpermission=root
set termusername=root
echo %brightgreen%Successfully Logged Into Root%brightwhite% && set banned=False
echo.
goto commandline

:roothelp
echo.
echo ╔Root User Help
echo ╚:Root Access Is REQUIRED
echo.
echo root-h :----: access this help menu
echo root-plant :: plant this file into %targetdir%
echo root-log :--: access log files
echo.
goto commandline

:plant
if not %userpermission%==root echo %brightred%User Permission Is Not Allowed%brightwhite% && goto commandline
if exist netwise.cmd move netwise.cmd C:\Users\%username%
if exist netwise.bat move netwise.bat C:\Users\%username%

:disablehelp
echo.
echo ╔Disable Help
echo ╚:Disable Items, Root Access Is REQUIRED for some operations
echo.
echo dis-h :----: shows this help menu
echo dis-notif :----: disables notifications temporarily
echo.
goto commandline

:disablenotif
if %displaynotifs%==True set displaynotifs=False && echo %brightgreen%Notifications Disabled For Current Session, %white%"%brightgreen%cls%white%" For Changes to Take Place && goto commandline
if %displaynotifs%==False echo %brightyellow%Notifications Are Already Disabled && goto commandline


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
echo %brightwhite%Ban Status :--------: %darkred%%banstatus%
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
echo %brightwhite%┌───────────────────────────────────────────────────┐┌──────────────────────────────────────────────────┐
echo │ %brightgreen%https://github.com/sjapanwala/netwise%brightwhite%             ││ %brightgreen%https://github.com/sjapanwala%brightwhite%                    │
echo └───────────────────────────────────────────────────┘└──────────────────────────────────────────────────┘ 
echo.
goto commandline

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
echo %white%Note: Enter "%brightgreen%ip-l%white%" To Enter Local IP (%localip%)
echo ┌(%brightred%%targetip%%brightwhite%)
set /p newip=└[Enter New IP]:
if "%newip%"=="ip-l" set newip=%localip%
echo ╔═══════════════IP Connection═════════════════╗
curl http://ip-api.com/line/%newip%?fields=query
curl http://ip-api.com/line/%newip%?fields=status
curl http://ip-api.com/line/%newip%?fields=message
curl http://ip-api.com/line/%newip%?fields=org
echo ╚═════════════════════════════════════════════╝
echo.
:setchoiceip
if %newip%==%safetydomain% echo %brightyellow%⚠️!: TEMP-TARGET IP AND SAFETY DOMAIN MATCH %brightwhite%
set /p choice=Set %newip% as Target IP? (Y/N): 
if %choice%==y goto settarget
if %choice%==Y goto settarget
if %choice%==N echo %brightyellow%IP Set Abborted && goto commandline
if %choice%==n echo %brightyellow%IP Set Abborted && goto commandline
goto setchoiceip
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
:ipdisplaytarget
echo.
if %targetip%==none echo %brightred% No IP Set, Please Set A Target IP First%brightwhite% && goto commandline
echo %brightcyan%
curl ip-api.com/%targetip%
echo.
goto commandline
:ipdisplaytarget2
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


:geniphelp
echo.
echo ╔Generate Random IP
echo ╚:Combines random numbers to generate a possible IP
echo.
echo genip-h :-----: shows this help menu
echo genip-create :: creates a singular random IP, shows whether said IP exists
echo genip-loop :--: creates multiples IP until a real IP is found (depends on API key, and Max Requests)
goto commandline
:genip
if %countercool%==True echo ❌: %brightred%This Command Has Been Temporarily Blocked.
echo.
set /a num=%random% %%4
set /a num1=%random% %%4
set /a num2=%random% %%4
set /a num3=%random% %%4
set /a num4=%random% %%4
set /a num5=%random% %%4
set /a num6=%random% %%4
set /a num7=%random% %%4
set /a num8=%random% %%4
set /a num9=%random% %%4
set /a num10=%random% %%4
set /a num11=%random% %%4
echo.
echo %brightgreen%Random IP Generated
echo %white%Note: This is a completely random generated IP. If connected to something important, its an entire coincident.
set generatedip=%num%%num1%%num2%.%num3%%num4%%num5%.%num6%%num7%%num8%.%num9%%num10%%num11%
echo.
echo Randomly Generated IP: %generatedip%
curl http://ip-api.com/line/%generatedip%?fields=status
goto commandline
:geniploop
if %countercool%==True echo ❌: %brightred%This Command Has Been Temporarily Blocked.
echo %white%Note: This Will Run Until A Valid IP is found
echo.
set counter=0
:startloop
if %counter%==20 set countercool=True && goto startup
set /a num=%random% %%4
set /a num1=%random% %%4
set /a num2=%random% %%4
set /a num3=%random% %%4
set /a num4=%random% %%4
set /a num5=%random% %%4
set /a num6=%random% %%4
set /a num7=%random% %%4
set /a num8=%random% %%4
set /a num9=%random% %%4
set /a num10=%random% %%4
set /a num11=%random% %%4
set generatedip=%num%%num1%%num2%.%num3%%num4%%num5%.%num6%%num7%%num8%.%num9%%num10%%num11%
for /f "tokens=*" %%i in ('curl -s "http://ip-api.com/line/%generatedip%?fields=status"') do set status=%%i
echo %brightred%%status%
echo %generatedip%
PING -n 1 8.8.8.8 | FIND "TTL=">nul
set /a counter+=1
if %status%==fail goto startloop
echo.
echo %brightwhite%Status: %brightgreen%[%status%]
echo %brightwhite%[%generatedip%] Was Successfully Found
echo.
:settargetrand
set /p choice=Set %generatedip% As TargetIP? (Y/N): 
if %choice%==y goto settargettrue
if %choice%==Y goto settargettrue
if %choice%==N echo %brightyellow%IP Set Abborted && goto commandline
if %choice%==n echo %brightyellow%IP Set Abborted && goto commandline
goto settargetrand
:settargettrue
set targetip=%generatedip%
echo %brightgreen%%generatedip% Has Been Set As New Target%white%
goto commandline

:updatehelp
echo.
echo ╔Generate Random IP
echo ╚:Combines random numbers to generate a possible IP
echo.
echo update-h :----: shows this help menu
echo update-a :----: allows user to update entire terminal
:updateall
echo.
echo %brightwhite%Welcome to %brightred%NetWise%brightwhite% Update Manager
echo.
echo [1] - Install Updates From Local Files
echo [2] - Install Updates From Network (curl)
echo.
set /p uptchoice=
if %uptchoice%==1 goto localfiles
if %uptchoice%==2 goto netfiles
goto commandline

:localfiles
echo.
echo %white%Note: All Paths Need To Be Green
echo %white%Note: File paths Need to Be Identical, Or Else Updates May Not Apply.
echo.
if %cd%==C:\Users\%username% echo %brightwhite%Current  File Path - %brightgreen%%cd%
if not %cd%==C:\Users\%username% echo %brightwhite%Current  File Path - %brightred%%cd%
echo %brightwhite%Desired  File Path - %brightgreen%C:\Users\%username%
echo %brightwhite%Download File Path - %brightgreen%C:\Users\%username%\.config\netwise
echo.
if exist C:\Users\%username%\.config\netwise\.updatefile echo %brightgreen%Updates Available
if not exist C:\Users\%username%\.config\netwise\.updatefile echo %brightyellow%No Updates Available
if exist C:\Users\%username%\.config\netwise\.updatefile goto applyupdt
goto commandline
:netfiles
set /p curllink=Please Enter Update Link Here: 
start %curllink% && goto applyupdate
:applyupdt
set /p applyupdate=%white%Apply Updates? (Y/N)?: 
if %applyupdate%==y goto applyupdate
if %applyupdate%==Y goto applyupdate
if %applyupdate%==N echo %brightyellow%Update Apply Abborted && goto commandline
if %applyupdate%==n echo %brightyellow%Update Apply Abborted && goto commandline
:applyupdate
echo. 
move C:\Users\%username%\.config\netwise\.updatefile C:\Users\%username%
::rename ".updatefile" ".netwise"
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightred%━━━━%white%━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightred%━━━━━━━━%white%━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightred%━━━━━━━━━━━━%white%━━━━━━━━━━━━━━━━━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightred%━━━━━━━━━━━━━━━━%white%━━━━━━━━━━━━━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightred%━━━━━━━━━━━━━━━━━━━━%white%━━━━━━━━━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightyellow%━━━━━━━━━━━━━━━━━━━━━━━━%white%━━━━━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightyellow%━━━━━━━━━━━━━━━━━━━━━━━━━━━━%white%━━━━━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightyellow%━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%white%━━━━━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightyellow%━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%white%━━━━]
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo %white%[%brightgreen%━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%white%]
echo.
echo %brightgreen%Great! Updates Successfully Applied.
echo %white%Note: Terminal Refreshing in 5 Seconds, Wait or Press Any Key.
timeout 5 >nul
::rename ".netwise" "netwise.bat"
start netwise.cmd && exit
goto commandline

:updatepackets
echo.
set /p choice=%brightwhite%Scan For Missing Files(Y/N)?: 
if %choice%==y goto search
if %choice%==Y goto search
if %choice%==N echo %brightyellow%Repair Abborted && goto commandline
if %choice%==n echo %brightyellow%Repair Abborted && goto commandline
:search
:: scan
if exist C:\Users\%username%\.config\netwise set configfolder=True
if exist C:\Users\%username%\.config\netwise\dump set dumpfolder=True
if exist C:\Users\%username%\.config\netwise\logs set logfolder=True
if exist C:\Users\%username%\.config\netwise\errors set errorfolder=True
:: notify
echo.
echo Config Folder = %configfolder%
echo Dump Folder   = %dumpfolder%
echo Log Folder    = %logfolder%
echo Error Folder  = %errorfolder%
echo.
set /p choice=%brightwhite%Apply Missing Files? (Y/N)?: 
if %choice%==y goto applymissingfiles
if %choice%==Y goto applymissingfiles
if %choice%==N echo %brightyellow%Repair Abborted && goto commandline
if %choice%==n echo %brightyellow%Repair Abborted && goto commandline
:applymissingfiles
echo %white%Please Wait
if "%configfolder%" NEQ "True" (
    md C:\Users\%username%\.config\netwise
)
if "%dumpfolder%" NEQ "True" (
    md C:\Users\%username%\.config\netwise\dump
)
if "%logfolder%" NEQ "True" (
    md C:\Users\%username%\.config\netwise\logs
)
if "%errorfolder%" NEQ "True" (
    md C:\Users\%username%\.config\netwise\error
)
echo %brightgreen%Finished Applying Files.
if %direrror%==True echo %brightred%Please Plant into User File.
goto commandline
