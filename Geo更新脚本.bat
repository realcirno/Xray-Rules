rem ------------------------------------ .BAT file start --------------------------
@echo OFF
SETLOCAL

chcp 65001
rem 通过 bitadmin.exe 程序进行URL文件下载

:SETUP
rem 下载源位置
SET "GEOIP_URL=https://github.com/realcirno/Xray-Rules/raw/release/geoip.dat"
SET "GEOSITE_URL=https://github.com/realcirno/Xray-Rules/raw/release/geosite.dat"
SET "GEOIPDB_URL=https://github.com/soffchen/sing-geoip/releases/latest/download/geoip.db"
SET "GEOSITEDB_URL=https://github.com/soffchen/sing-geosite/releases/latest/download/geosite.db"
rem 保存到哪里:（请自行修改)
SET "GEOIP_SAVING_TO=D:\Program Files\nekoray\geoip.dat"
SET "GEOSITE_SAVING_TO=D:\Program Files\nekoray\geosite.dat"
SET "GEOIPDB_SAVING_TO=D:\Program Files\nekoray\geoip.db"
SET "GEOSITEDB_SAVING_TO=D:\Program Files\nekoray\geosite.db"

rem 保存到当前目录
REM SET "GEOSITE_SAVING_TO=%~dp0%geosite.dat"
REM SET "GEOIP_SAVING_TO=%~dp0%geoip.dat"
REM SET "GEOSITEDB_SAVING_TO=%~dp0%geosite.db"
REM SET "GEOIPDB_SAVING_TO=%~dp0%geoip.db"

:MAIN
CLS
ECHO.
ECHO **************************************************************
ECHO ** **                                                    ** **
ECHO ** Loyalsoldier 版Geo系列 文件更新下载（下载前确保代理状态）**
ECHO ** **                                                    ** **
ECHO **************************************************************
ECHO.
ECHO geoip.dat文件下载源: "%geoip_URL%"
ECHO geosite.dat文件下载源: "%geosite_URL%"
ECHO geoip.db文件下载源: "%geoipdb_URL%"
ECHO geosite.db文件下载源: "%geositedb_URL%"
ECHO.
ECHO 【 geoip.dat 保存到 】: "%GEOIP_SAVING_TO%"
ECHO 【 geosite.dat 保存到 】: "%GEOSITE_SAVING_TO%"
ECHO 【 geoip.db 保存到 】: "%GEOIPDB_SAVING_TO%"
ECHO 【 geosite.db 保存到 】: "%GEOSITEDB_SAVING_TO%"
ECHO.
ECHO.
PAUSE "确认后，按任意键开始下载........"
ECHO **********************************************
ECHO.
bitsadmin /create mydownloadjob

rem 进行下载的命令:
CALL :DOWNLOAD_FILE "%GEOIP_URL%" "%GEOIP_SAVING_TO%"
CALL :DOWNLOAD_FILE "%GEOSITE_URL%" "%GEOSITE_SAVING_TO%"
CALL :DOWNLOAD_FILE "%GEOIPDB_URL%" "%GEOIPDB_SAVING_TO%"
CALL :DOWNLOAD_FILE "%GEOSITEDB_URL%" "%GEOSITEDB_SAVING_TO%"

rem UNCOMMENT NEXT LINE FOR DISABLING THE PROXY (IF YOU USED IT):
REM CALL :DOWNLOAD_PROXY_OFF

:RESULT
ECHO.
bitsadmin /complete mydownloadjob
IF EXIST "%GEOIP_SAVING_TO%" ECHO 文件("%GEOIP_SAVING_TO%") 下载成功,请重新启动代理.
IF EXIST "%GEOSITE_SAVING_TO%" ECHO 文件("%GEOSITE_SAVING_TO%") 下载成功,请重新启动代理.
IF EXIST "%GEOIPDB_SAVING_TO%" ECHO 文件("%GEOIPDB_SAVING_TO%") 下载成功,请重新启动代理.
IF EXIST "%GEOSITEDB_SAVING_TO%" ECHO 文件("%GEOSITEDB_SAVING_TO%") 下载成功,请重新启动代理.
IF NOT EXIST "%GEOIP_SAVING_TO%" ECHO 【 ！！！！ ERROR 】, YOUR FILE("%GEOIP_SAVING_TO%") COULDN'T BE DOWNLOADED.
IF NOT EXIST "%GEOSITE_SAVING_TO%" ECHO 【 ！！！！ ERROR 】, YOUR FILE("%GEOSITE_SAVING_TO%") COULDN'T BE DOWNLOADED.
IF NOT EXIST "%GEOIPDB_SAVING_TO%" ECHO 【 ！！！！ ERROR 】, YOUR FILE("%GEOIPDB_SAVING_TO%") COULDN'T BE DOWNLOADED.
IF NOT EXIST "%GEOSITEDB_SAVING_TO%" ECHO 【 ！！！！ ERROR 】, YOUR FILE("%GEOSITEDB_SAVING_TO%") COULDN'T BE DOWNLOADED.
ECHO.

:EXIT_SCRIPT
PAUSE
EXIT /B

rem 配置函数

:DOWNLOAD_FILE
rem 使用BITSADMIN命令来下载文件:
bitsadmin /transfer mydownloadjob /download /priority FOREGROUND %1 %2
GOTO :EOF

:DOWNLOAD_PROXY_ON
rem 通过代理进行下载:
bitsadmin /setproxysettings mydownloadjob OVERRIDE %1 NULL
GOTO :EOF

:DOWNLOAD_PROXY_OFF
rem 停止使用代理:
bitsadmin /setproxysettings mydownloadjob1 NO_PROXY
GOTO :EOF
rem ------------------------------------ .BAT file END --------------------------