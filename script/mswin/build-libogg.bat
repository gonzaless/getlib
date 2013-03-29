
if %libcfg% NEQ lib (
	echo.  WARNING: no rule to build the library %libname% for the specified target "%libcfg%" - skip
	goto end
)

if "%toolset%"=="msvc-10.0" (
	set keydir=VS2010
)  else if "%toolset%"=="msvc-11.0" (
	set keydir=VS2012
)  else if "%toolset%"=="msvc-12.0" (
	set keydir=VS2014
)

set config=%defbuildcfg%
set libfile=libogg_static
set project=win32\%keydir%\libogg_static.vcxproj

echo.    project='%project%' 
echo.    config=%config%
%compiler% /t:%command% /p:Configuration=%config% /nologo /m /clp:ErrorsOnly /fl /flp:logfile=%liblog% %project%
goto %command%

:build
:rebuild
	:: lib
	echo.  copy lib files:
	copy win32\%keydir%\%platform_str%\%configure_str%\%libfile%.lib "%outdir-lib%\"
	
	:: include
	echo.  copy include files:
	xcopy include\ogg\* "%outdir-include%\ogg\" /Q /Y /S
	
	goto end

:clean
	goto end

:end