@echo off
title Monitor de CPU y RAM
setlocal EnableDelayedExpansion

REM ====== UMBRALES ======
set ThresholdCierre=95
set ThresholdLimpieza=98

cls
echo ================== MONITOR DE RECURSOS ==================
echo Monitoreando cada 10 segundos... (Presiona CTRL+C para salir)
echo Umbrales: Cierre=%ThresholdCierre%%% / Limpieza=%ThresholdLimpieza%%%
echo ==========================================================
echo.

:LOOP
REM ----- OBTENER CPU CON POWERSHELL -----
for /f %%i in ('powershell -command "Get-WmiObject Win32_Processor | Select-Object -ExpandProperty LoadPercentage"') do set CpuLoad=%%i

REM ----- OBTENER RAM CON POWERSHELL -----
for /f %%i in ('powershell -command "$os = Get-WmiObject Win32_OperatingSystem; [math]::Round((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100)"') do set UsedMem=%%i

REM ----- OBTENER MEMORIA LIBRE -----
for /f %%i in ('powershell -command "(Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory"') do set FreeMem=%%i

REM ----- OBTENER MEMORIA TOTAL -----
for /f %%i in ('powershell -command "(Get-WmiObject Win32_OperatingSystem).TotalVisibleMemorySize"') do set TotalMem=%%i

REM Validar que los valores no estén vacíos
if "%CpuLoad%"=="" set CpuLoad=0
if "%UsedMem%"=="" set UsedMem=0
if "%FreeMem%"=="" set FreeMem=0
if "%TotalMem%"=="" set TotalMem=0

REM Mostrar resultados
echo [%time%] CPU: %CpuLoad%%% - RAM: %UsedMem%%% - Libre: %FreeMem% KB - Total: %TotalMem% KB

REM ====== ACCIONES POR UMBRALES ======

REM --- CIERRE DE PROGRAMAS A PARTIR DEL 95%% ---
if %CpuLoad% GEQ %ThresholdCierre% (
    echo.
    echo *** Umbral de %ThresholdCierre%%% superado por CPU - cerrando programas...
    call :CerrarProgramas
)

if %UsedMem% GEQ %ThresholdCierre% (
    echo.
    echo *** Umbral de %ThresholdCierre%%% superado por RAM - cerrando programas...
    call :CerrarProgramas
)

REM --- LIMPIEZA DE TEMPORALES A PARTIR DEL 98%% ---
if %CpuLoad% GEQ %ThresholdLimpieza% (
    echo.
    echo *** Umbral de %ThresholdLimpieza%%% superado por CPU - limpiando temporales...
    call :LimpiarTemporales
)

if %UsedMem% GEQ %ThresholdLimpieza% (
    echo.
    echo *** Umbral de %ThresholdLimpieza%%% superado por RAM - limpiando temporales...
    call :LimpiarTemporales
)

REM Espera 10 segundos antes de la siguiente lectura
timeout /t 10 /nobreak >nul
goto :LOOP


REM ==============================================
REM ========== FUNCION: CERRAR PROGRAMAS =========
REM ==============================================
:CerrarProgramas
for %%P in (
    chrome.exe
    excel.exe
    winword.exe
    notepad.exe
) do (
    taskkill /IM "%%P" /F >nul 2>&1
)
exit /b


REM ==============================================
REM ======== FUNCION: LIMPIAR TEMPORALES =========
REM ==============================================
:LimpiarTemporales
echo.
echo --- Limpiando carpetas temporales ---
echo Limpiando %%TEMP%% del usuario...
del /f /q /s "%TEMP%\*.*" >nul 2>&1
echo Limpiando C:\Windows\Temp ...
del /f /q /s "C:\Windows\Temp\*.*" >nul 2>&1
echo Limpieza de temporales finalizada.
echo.
exit /b
