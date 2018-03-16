@echo off
::
:: This is free and unencumbered software released into the public domain.
::
:: Anyone is free to copy, modify, publish, use, compile, sell, or
:: distribute this software, either in source code form or as a compiled
:: binary, for any purpose, commercial or non-commercial, and by any
:: means.
::
:: In jurisdictions that recognize copyright laws, the author or authors
:: of this software dedicate any and all copyright interest in the
:: software to the public domain. We make this dedication for the benefit
:: of the public at large and to the detriment of our heirs and
:: successors. We intend this dedication to be an overt act of
:: relinquishment in perpetuity of all present and future rights to this
:: software under copyright law.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
:: EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
:: MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
:: IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
:: OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
:: ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
:: OTHER DEALINGS IN THE SOFTWARE.
::
:: For more information, please refer to <http://unlicense.org>
::
setlocal EnableDelayedExpansion
if "%1"=="" goto :usage
pushd "%~dp0"
goto :main
popd
goto :EOF

:main
for %%c in (git-*) do (
    if not exist "%~1\%%c" (
        mklink "%~1\%%c" "%%~fc" || exit /b 1
        echo %%c was installed.
    ) else (
        echo %%c is already installed.
    )
)
echo.
echo Installation is complete.
echo.
echo If you like, you can set-up convenience aliases for the commands by
echo executing following configurations:
echo.
for %%c in (git-*.cmd) do (
    set ALIAS=%%c
    set ALIAS=!ALIAS:~4,-4!
    echo git config --global alias.!ALIAS! !ALIAS!.cmd
)
goto :EOF

:usage
echo Usage: %~nx0 TARGET_DIR
echo.
echo Installs symbol links in TARGET_DIR for every Git command found in
echo the same directory as this program. Ideally, TARGET_DIR is in PATH
echo so that Git can find the command.
exit /b 1
