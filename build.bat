@echo off
echo ========================================
echo Building SIMPL Parser with JFlex and CUP
echo ========================================
echo.

REM Check if JFlex jar exists
if not defined JFLEX_JAR (
    echo JFLEX_JAR environment variable not set, using default path...
    set JFLEX_JAR=D:/Siddharth/jflex-1.9.1/lib/jflex-full-1.9.1.jar
)
if not exist "%JFLEX_JAR%" (
    echo ERROR: JFlex jar not found at: %JFLEX_JAR%
    echo Please set JFLEX_JAR environment variable to the path of jflex-full-*.jar
    echo Example: set JFLEX_JAR=C:\tools\jflex-1.9.1\lib\jflex-full-1.9.1.jar
    echo Download JFlex from https://www.jflex.de/
    pause
    exit /b 1
)

REM Check if CUP jar exists
if not defined CUP_JAR (
    echo CUP_JAR environment variable not set, using default path...
    set CUP_JAR=D:/Siddharth/java-cup-bin-11b-20160615/java-cup-11b.jar
)
if not exist "%CUP_JAR%" (
    echo ERROR: CUP jar not found at: %CUP_JAR%
    echo Please set CUP_JAR environment variable to the path of java-cup-*.jar
    echo Example: set CUP_JAR=C:\tools\java-cup-11b.jar
    echo Download Java CUP from http://www2.cs.tum.edu/projects/cup/
    pause
    exit /b 1
)

echo Step 1: Generating lexer from simpl.flex...
java -jar "%JFLEX_JAR%" simpl.flex
if %errorlevel% neq 0 (
    echo ERROR: JFlex generation failed!
    pause
    exit /b %errorlevel%
)

echo Step 2: Generating parser from simpl.cup...
java -jar "%CUP_JAR%" -parser SimplParser -symbols sym simpl.cup
if %errorlevel% neq 0 (
    echo ERROR: CUP generation failed!
    pause
    exit /b %errorlevel%
)

echo Step 3: Compiling all Java files...
javac -cp "%CUP_JAR%" *.java
if %errorlevel% neq 0 (
    echo ERROR: Compilation failed!
    pause
    exit /b %errorlevel%
)

echo.
echo ========================================
echo SUCCESS: Build completed!
echo ========================================
echo Generated files:
echo   - SimplLexer.java (from JFlex)
echo   - SimplParser.java (from CUP)
echo   - sym.java (from CUP - already existed)
echo.
pause
