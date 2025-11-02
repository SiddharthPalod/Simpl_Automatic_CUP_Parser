@echo off
echo ========================================
echo Cleaning generated and compiled files
echo ========================================
echo.

REM Remove generated Java files
if exist SimplLexer.java (
    echo Removing SimplLexer.java...
    del /Q SimplLexer.java
)

if exist SimplParser.java (
    echo Removing SimplParser.java...
    del /Q SimplParser.java
)

if exist sym.java (
    echo Removing sym.java...
    del /Q sym.java
)

REM Remove compiled class files
echo Removing compiled .class files...
del /Q *.class 2>nul

REM Remove backup files if any
if exist SimplLexer.java~ (
    echo Removing backup file SimplLexer.java~...
    del /Q SimplLexer.java~
)

echo.
echo ========================================
echo Clean completed!
echo ========================================
echo.
echo Removed files:
echo   SimplLexer.java
echo   SimplParser.java
echo   sym.java
echo   All .class files
echo.
echo To regenerate, run: build.bat
echo.
pause
