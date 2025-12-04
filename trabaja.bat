@echo off
:inicio
cls
REM Generar número aleatorio entre 1 y 9 para colores
set /a colorNum=%random% %% 16
REM Cambiar color (colorNum es un dígito hexadecimal)
REM El primer dígito es el fondo, el segundo el texto
REM Usamos 0 (negro) como fondo
color 0%colorNum%
echo "tlabaja tienes que tlabajal  >:v"
timeout /t 1 >nul
goto inicio
