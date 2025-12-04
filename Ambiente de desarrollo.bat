@echo off
title Menu de Desarrollo Bizzarro
setlocal enabledelayedexpansion

:: Carpeta base donde se descargarán los repositorios
set DESTINO=%USERPROFILE%\Repos\POSOne

:: Verificar si Git está instalado
where git >nul 2>nul
    if %errorlevel% neq 0 (
        echo ERROR: Git no está instalado o no está en la variable de entorno PATH.
        echo Descárgalo desde https://git-scm.com/
        pause
        exit /b
    )

:: Crear carpeta si no existe
    if not exist "%DESTINO%" mkdir "%DESTINO%"

:menu
cls
        echo ===========================
        echo  MENU - GESTION DE REPOS
        echo ===========================
        echo  1. Clonar un repositorio
        echo  2. Salir
        echo ===========================
        set /p opcion=Seleccione una opcion: 

        if "%opcion%"=="1" goto submenu_clonar
        if "%opcion%"=="2" exit
    echo Opción no válida...
    pause
    goto menu

:submenu_clonar
    cls
        echo ===============================================
        echo          SUBMENÚ - CLONAR REPOS
        echo ===============================================
        echo  1. Clonar POSONE Request
        echo  2. Clonar POSONE Base de Datos
        echo  3. Clonar POSOne cliente (Punto de venta)
        echo  8. Abir ubicacion
        echo  9. Menu inicial


        echo ===========================
        set /p subopcion=Seleccione una opcion: 

        if "%subopcion%"=="1" goto clonar_PROPOSONE_Request
        if "%subopcion%"=="2" goto clonar_Base_datos
        if "%subopcion%"=="3" goto clonar_POSOne_cliente
        if "%subopcion%"=="4" goto clonar_no_definido1
        if "%subopcion%"=="8" goto abrir_ubicacion 
        if "%subopcion%"=="9" goto menu
            echo Opción no válida...
            pause
            goto submenu_clonar

    :clonar_PROPOSONE_Request
        cls
        echo Creando carpeta PROPOSONE_Request...
        set subfolder=%DESTINO%\PROPOSONE_Request
        if not exist "%subfolder%" mkdir "%subfolder%"

        echo Clonando los 5 repositorios dentro de PROPOSONE_Request...
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/AGA_GENERAL_Conexion.git" "AGA_GENERAL_Conexion"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_APIRestCliente.git" "PRO_POSONE_APIRestCliente"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_NucleoAPIRest.git" "PRO_POSONE_NucleoAPIRest"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_Request.git" "PRO_POSONE_Request"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_Seguridad.git" "PRO_POSONE_Seguridad"

        echo Todos los repositorios han sido clonados.
        pause
        goto submenu_clonar

        :: ===========================
        ::   FUNCION CLONAR SUBREPO
        :: ===========================
        :clonar_subrepo
        :: Parámetros: %1 = URL del repo, %2 = Nombre de la carpeta
        setlocal
        set repo_url=%~1
        set repo_folder=%~2

        echo ===========================
        echo Clonando %repo_folder%...
        echo ===========================

        :: Ir a la carpeta de destino
        pushd "%subfolder%"

            :: Verificar si la carpeta del repo ya existe
            if exist "%repo_folder%" (
                echo El repositorio %repo_folder% ya existe. Actualizando...
                cd "%repo_folder%"
                git pull
            ) else (
                echo Descargando %repo_folder% desde %repo_url%...
                git clone "%repo_url%" "%repo_folder%"
            )
        :: Regresar a la carpeta anterior
        popd
        endlocal
    exit /b

:::::::::::::::::::::::::::::::::::::::


:clonar_Base_datos
        cls
        echo Creando carpeta PRO_POSONE_InstaladorBD_Local...
        set subfolder=%DESTINO%\PRO_POSONE_InstaladorBD_Local
        if not exist "%subfolder%" mkdir "%subfolder%"

        echo Clonando repositorios de base de datos  ...
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_InstaladorBD_Local.git" "PRO_POSONE_InstaladorBD_Local"
      
        echo Repositorio clonado validar configuracion con el manual de usuario de desarrollo.
        pause
        goto submenu_clonar
        :clonar_subrepo
        :: Parámetros: %1 = URL del repo, %2 = Nombre de la carpeta
        setlocal
        set repo_url=%~1
        set repo_folder=%~2

        echo ===========================
        echo Clonando %repo_folder%...
        echo ===========================

        :: Ir a la carpeta de destino
        pushd "%subfolder%"

            :: Verificar si la carpeta del repo ya existe
            if exist "%repo_folder%" (
                echo El repositorio %repo_folder% ya existe. Actualizando...
                cd "%repo_folder%"
                git pull
            ) else (
                echo Descargando %repo_folder% desde %repo_url%...
                git clone "%repo_url%" "%repo_folder%"
            )
        :: Regresar a la carpeta anterior

        :: Imprimir el directorio actual
                echo ===========================
                echo Directorio actual: %cd%
                echo ===========================

            :: Detener el script y esperar que el usuario presione una tecla

        popd
    endlocal
exit /b

:::::::::::::::::::::::::::::::::::::::::
    :clonar_POSOne_cliente 
        cls
        echo Creando carpeta clonar_POSOne_cliente...
        set subfolder=%DESTINO%\POSOne_cliente
        if not exist "%subfolder%" mkdir "%subfolder%"

        echo Clonando los 5 repositorios dentro de PROPOSONE_Request...
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/AGA_GENERAL_Conexion.git" "AGA_GENERAL_Conexion"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_APIRestCliente.git" "PRO_POSONE_APIRestCliente"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_Cliente.git" "PRO_POSONE_Cliente"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_NucleoAPIRest.git" "PRO_POSONE_NucleoAPIRest"
        call :clonar_subrepo "https://gitlab.com/bzrdaisa/sap/posone/PRO_POSONE_Seguridad.git" "PRO_POSONE_Seguridad"

        echo Todos los repositorios han sido clonados.
        pause
        goto submenu_clonar

        :: ===========================
        ::   FUNCION CLONAR SUBREPO
        :: ===========================
        :clonar_subrepo
        :: Parámetros: %1 = URL del repo, %2 = Nombre de la carpeta
        setlocal
        set repo_url=%~1
        set repo_folder=%~2

        echo ===========================
        echo Clonando %repo_folder%...
        echo ===========================

        :: Ir a la carpeta de destino
        pushd "%subfolder%"

            :: Verificar si la carpeta del repo ya existe
            if exist "%repo_folder%" (
                echo El repositorio %repo_folder% ya existe. Actualizando...
                cd "%repo_folder%"
                git pull
            ) else (
                echo Descargando %repo_folder% desde %repo_url%...
                git clone "%repo_url%" "%repo_folder%"
            )

        :: Regresar a la carpeta anterior
        popd
        endlocal
:::::::::::::::::::::::::::::::::::::::
    :abrir_ubicacion 
    cls
    echo Abriendo la carpeta %DESTINO%...
    start explorer "%DESTINO%"

exit /b
