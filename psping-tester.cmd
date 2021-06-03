@echo off
:: psping Tester v1.1
:: by: Romel Vera
:: Date: April 1 2017
:: Updated: June 2 2021
:: License: MIT

cls
title psping Tester
color 1F

set BATDIR1=%~dp0
cd /d %BATDIR1%

REM -------------------------
REM     Modify this only
REM -------------------------
:: Ping Interval is in seconds (value of 0 for fast ping)
:: Test duration only works for bandwidth and latency tests (append 's' to specify seconds e.g. '10s')
:: For request size. Append 'k' for kilobytes and 'm' for megabytes (only works for bandwidth and latency tests)
set port=6000
set ip=127.0.0.1
set executable=psping64.exe
set warm=3
set pingcount=10
set pinginterval=0
set testduration=10s
set tcpRequestSize=8k
set bandwidthRequestSize=1m
REM -------------------------

:Menu
cls
Echo+
Echo -------------------------------------------------------------------------------
Echo    psping Tester                           By: Romel Vera
Echo -------------------------------------------------------------------------------
Echo+
echo Hello %USERNAME%, what do you want to do?
echo+
echo Current Target: %ip%
echo Current Port: %port%
echo+
echo    A) Ping Target
echo    B) Test TCP Connection
echo+
echo    C) Start a server for latency and bandwidth tests
echo    D) TCP round trip latency test
echo    E) Bandwidth test
echo+
echo    X) Configure IP and Port
echo    Q) Exit
echo+

set /p userinp= ^> Select Option : 
set userinp=%userinp:~0,1%
if /i "%userinp%"=="Q" exit
if /i "%userinp%"=="A" goto :simple
if /i "%userinp%"=="B" goto :tcptest
if /i "%userinp%"=="C" goto :server
if /i "%userinp%"=="D" goto :latency
if /i "%userinp%"=="E" goto :bandwidth
if /i "%userinp%"=="X" goto :configure
goto :Menu

:configure
cls
set /p ip= ^> Enter IP or Hostname : 
set /p port= ^> Enter Port : 
goto :Menu

:simple
cls
rem psping.exe -n 10 -w 3 [ip or hostname]
%executable% -n %pingcount% -w %warm% -i %pinginterval% %ip% -nobanner
echo+
pause
goto :Menu

:tcptest
cls
rem psping -n 10 -i 0 -q [ip]:[port]
%executable% -n %pingcount% -w %warm% -i %pinginterval% -q %ip%:%port% -nobanner
echo+
pause
goto :Menu

:server
cls
rem psping -s [ip]:[port]
%executable% -f -s %ip%:%port%
echo+
pause
goto :Menu

:latency
cls
rem psping -l 8k -n 10000 -h 100 [ip]:[port]
%executable% -f -l %tcpRequestSize% -n %testduration% -w %warm% %ip%:%port% -nobanner
echo+
pause
goto :Menu

:bandwidth
cls
rem psping -b -l 8k -n 10000 -h 100 [ip]:[port]
%executable% -f -b -l %bandwidthRequestSize% -n %testduration% -w %warm% %ip%:%port% -nobanner
echo+
pause
goto :Menu
