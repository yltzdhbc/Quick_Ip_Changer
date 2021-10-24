

:: ----这一段是直接使用管理员方式打开----

@echo off
cd /d "%~dp0"
cacls.exe "%SystemDrive%\System Volume Information" >nul 2>nul
if %errorlevel%==0 goto Admin
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
echo Set RequestUAC = CreateObject^("Shell.Application"^)>"%temp%\getadmin.vbs"
echo RequestUAC.ShellExecute "%~s0","","","runas",1 >>"%temp%\getadmin.vbs"
echo WScript.Quit >>"%temp%\getadmin.vbs"
"%temp%\getadmin.vbs" /f
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
exit

:Admin


set NET_NAME=以太网

::设置关闭回显和变量延迟
@echo off & setlocal EnableDelayedExpansion
::设置标题文字
title IP地址快速修改脚本 %NET_NAME% (by ylt)
::设置背景黑色，字体浅绿色
color 0A

:: rem # ----IP控制管理----

@echo off

@REM for /f "delims=: tokens=2" %%i in ('ipconfig ^| find /i "IPv4"') do set ip=%%i 
@REM echo %ip% 



echo =========%NET_NAME% IP 控制管理==========
echo =====该命令仅处理%NET_NAME%的IP地址======

@REM for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
@REM  set IP=%%a
@REM )
@REM echo 当前的IP地址为:%IP%
echo -
echo 0: 修改为：192.168.0.233
echo 1: 修改为：192.168.1.233
echo 2: 修改为：192.168.2.233

echo 4: 修改为：DHCP自动获取IP
echo 5: 手动输入需要修改的地址

echo 7: 修改为：192.168.4.100
echo 8: 修改为：169.254.1.233
echo -
echo 如果需要修改网络名称，请右键编辑在第20行更改
echo 请输入对应的序号,按回车键结束:

set /p ch=
if %ch%=="" echo "你输入了空的指令" &goto :EOF 
set case=0,1,2,4,5,7,8>nul
echo %case%|findstr "\<%ch%\>">nul&if errorlevel 1  goto :err
goto %ch%
goto err

:0
echo 正在修改 %NET_NAME% IP，请等待 ...
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.0.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.0.233 validate=no
echo 完成！已修改%NET_NAME% IP为：192.168.0.233，回车退出！
pause
goto :EOF

:1
echo "正在修改%NET_NAME% IP，请等待 ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.1.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.1.233 validate=no
echo "完成！已修改%NET_NAME% IP为：192.168.1.233，回车退出！"
pause
goto :EOF

:2
echo "正在修改%NET_NAME% IP，请等待 ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.2.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.2.233 validate=no
echo "完成！已修改%NET_NAME% IP为：192.168.2.233，回车退出！"
pause
goto :EOF


:4
:DHCP "自动获取IP地址"
echo "正在修改%NET_NAME% IP，请等待 ..."
netsh interface ip set address name="%NET_NAME%" dhcp >nul
netsh interface ip set dns name="%NET_NAME%" dhcp>nul
echo "完成！已修改%NET_NAME% 为：DHCP，回车退出！"
pause
goto :EOF

:5
:DHCP "手动输入需要修改的地址"
echo "请手动输入需要修改的地址 ..."
set /p input_ip=
if %input_ip%==""  echo "You input invalid ip" &goto :EOF 
echo "你输入的IP地址为："%input_ip%
netsh interface ip set address name="%NET_NAME%" source=static addr=%input_ip% mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=%input_ip% validate=no
echo "完成！已修改%NET_NAME% 为：%input_ip%，回车退出！"
pause
goto :EOF

:6
echo "正在修改%NET_NAME% IP，请等待 ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.4.100 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.4.100 validate=no
echo "完成！已修改%NET_NAME% IP为：192.168.4.100，回车退出！"
pause
goto :EOF

:7
echo "正在修改IP，请等待 ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=169.254.1.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=169.254.1.233 validate=no
echo "完成！已修改%NET_NAME% IP为：169.254.1.233，回车退出！"
pause
goto :EOF


:err
:: "error"
echo your input "%ch%" ,no this argument ! check your input!  game over
rem # 接口 IP 配置结束

