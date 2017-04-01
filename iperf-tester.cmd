@echo off
:: iperf Tester v1.0
:: by: Romel Vera
:: Date: April 1 2017
:: License: MIT

cls
title iperf Tester
color 1F

set BATDIR1=%~dp0
cd /d %BATDIR1%

REM -------------------------
REM     Modify this only
REM -------------------------
set port=5001
set ip=127.0.0.1
set executable=iperf3.exe
set testduration=20
set bandwidth=50m
set interval=2
REM -------------------------

:Menu
cls
Echo+
Echo -------------------------------------------------------------------------------
Echo    iperf Tester                           By: Romel Vera
Echo -------------------------------------------------------------------------------
Echo+
echo Hello %USERNAME%, what do you want to do?
echo+
echo Current Target: %ip%
echo Current Port: %port%
echo+
echo    A) Start Server Mode
echo+
echo    B) Simple Run (10 seconds)
echo    C) Simple Reverse (10 seconds)
echo+
echo    D) Test with custom Bandwidth: %bandwidth% in Megabits 
echo    E) Test with custom Time: %testduration% seconds with an interval of %interval% seconds
echo+
echo    X) Configure IP and Port
echo    Z) Configure Bandwidth, Duration, Interval
echo    Q) Exit
echo+

set /p userinp= ^> Select Option : 
set userinp=%userinp:~0,1%
if /i "%userinp%"=="Q" exit
if /i "%userinp%"=="X" goto :configure
if /i "%userinp%"=="Z" goto :configurebandw

if /i "%userinp%"=="A" goto :server
if /i "%userinp%"=="B" goto :simple
if /i "%userinp%"=="C" goto :reverse
if /i "%userinp%"=="D" goto :testbandw
if /i "%userinp%"=="E" goto :timed
goto :Menu

:configure
cls
set /p ip= ^> Enter IP or Hostname : 
set /p port= ^> Enter Port : 
goto :Menu

:configurebandw
cls
echo+
echo You can press enter to leave the current value
echo+
echo -- Input Bandwidth Value --
echo example for 100 megabits, type: 100m
echo+
set /p bandwidth= ^> Enter bandwidth : 
echo+
echo -- Input Time Value --
echo example for 15 seconds, type: 15
echo+
set /p testduration= ^> Enter duration : 
echo+
echo -- Input Time Value --
echo example to report every 2 seconds, type: 2
echo+
set /p interval= ^> Enter interval : 
goto :Menu

:server
cls
rem iperf3.exe -s -p [port]
%executable% -s -p %port%
echo+
pause
goto :Menu

:simple
cls
rem iperf3.exe -c [ip] -p [port]
%executable% -c %ip% -p %port%
echo+
pause
goto :Menu

:reverse
cls
rem iperf3.exe -c [ip] -p [port] -R
%executable% -c %ip% -p %port% -R
echo+
pause
goto :Menu

:testbandw
cls
rem iperf3.exe -c [ip] -p [port] -b 50m
%executable% -c %ip% -p %port% -b %bandwidth%%
echo+
pause
goto :Menu

:timed
cls
rem iperf3.exe -c [ip] -p [port] -t 30 -i 2
%executable% -c %ip% -p %port% -t %testduration% -i %interval%
echo+
pause
goto :Menu