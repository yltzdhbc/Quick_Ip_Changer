

:: ----��һ����ֱ��ʹ�ù���Ա��ʽ��----

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


set NET_NAME=��̫��

::���ùرջ��Ժͱ����ӳ�
@echo off & setlocal EnableDelayedExpansion
::���ñ�������
title IP��ַ�����޸Ľű� %NET_NAME% (by ylt)
::���ñ�����ɫ������ǳ��ɫ
color 0A

:: rem # ----IP���ƹ���----

@echo off

@REM for /f "delims=: tokens=2" %%i in ('ipconfig ^| find /i "IPv4"') do set ip=%%i 
@REM echo %ip% 



echo =========%NET_NAME% IP ���ƹ���==========
echo =====�����������%NET_NAME%��IP��ַ======

@REM for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
@REM  set IP=%%a
@REM )
@REM echo ��ǰ��IP��ַΪ:%IP%
echo -
echo 0: �޸�Ϊ��192.168.0.233
echo 1: �޸�Ϊ��192.168.1.233
echo 2: �޸�Ϊ��192.168.2.233

echo 4: �޸�Ϊ��DHCP�Զ���ȡIP
echo 5: �ֶ�������Ҫ�޸ĵĵ�ַ

echo 7: �޸�Ϊ��192.168.4.100
echo 8: �޸�Ϊ��169.254.1.233
echo -
echo �����Ҫ�޸��������ƣ����Ҽ��༭�ڵ�20�и���
echo �������Ӧ�����,���س�������:

set /p ch=
if %ch%=="" echo "�������˿յ�ָ��" &goto :EOF 
set case=0,1,2,4,5,7,8>nul
echo %case%|findstr "\<%ch%\>">nul&if errorlevel 1  goto :err
goto %ch%
goto err

:0
echo �����޸� %NET_NAME% IP����ȴ� ...
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.0.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.0.233 validate=no
echo ��ɣ����޸�%NET_NAME% IPΪ��192.168.0.233���س��˳���
pause
goto :EOF

:1
echo "�����޸�%NET_NAME% IP����ȴ� ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.1.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.1.233 validate=no
echo "��ɣ����޸�%NET_NAME% IPΪ��192.168.1.233���س��˳���"
pause
goto :EOF

:2
echo "�����޸�%NET_NAME% IP����ȴ� ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.2.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.2.233 validate=no
echo "��ɣ����޸�%NET_NAME% IPΪ��192.168.2.233���س��˳���"
pause
goto :EOF


:4
:DHCP "�Զ���ȡIP��ַ"
echo "�����޸�%NET_NAME% IP����ȴ� ..."
netsh interface ip set address name="%NET_NAME%" dhcp >nul
netsh interface ip set dns name="%NET_NAME%" dhcp>nul
echo "��ɣ����޸�%NET_NAME% Ϊ��DHCP���س��˳���"
pause
goto :EOF

:5
:DHCP "�ֶ�������Ҫ�޸ĵĵ�ַ"
echo "���ֶ�������Ҫ�޸ĵĵ�ַ ..."
set /p input_ip=
if %input_ip%==""  echo "You input invalid ip" &goto :EOF 
echo "�������IP��ַΪ��"%input_ip%
netsh interface ip set address name="%NET_NAME%" source=static addr=%input_ip% mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=%input_ip% validate=no
echo "��ɣ����޸�%NET_NAME% Ϊ��%input_ip%���س��˳���"
pause
goto :EOF

:6
echo "�����޸�%NET_NAME% IP����ȴ� ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=192.168.4.100 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=192.168.4.100 validate=no
echo "��ɣ����޸�%NET_NAME% IPΪ��192.168.4.100���س��˳���"
pause
goto :EOF

:7
echo "�����޸�IP����ȴ� ..."
netsh interface ip set address name="%NET_NAME%" source=static addr=169.254.1.233 mask=255.255.255.0
netsh interface ip set dns name="%NET_NAME%" source=static addr=169.254.1.233 validate=no
echo "��ɣ����޸�%NET_NAME% IPΪ��169.254.1.233���س��˳���"
pause
goto :EOF


:err
:: "error"
echo your input "%ch%" ,no this argument ! check your input!  game over
rem # �ӿ� IP ���ý���

