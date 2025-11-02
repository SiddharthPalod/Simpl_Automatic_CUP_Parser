@echo off
echo ========================================
echo Testing All SIMPL Example Programs
echo ========================================
echo.

REM Check if CUP jar is set, use default if not
if not defined CUP_JAR (
    echo CUP_JAR environment variable not set, using default path...
    set CUP_JAR=D:/Siddharth/java-cup-bin-11b-20160615/java-cup-11b.jar
)

REM Check if generated files exist, build if needed
if not exist SimplLexer.java (
    echo Generated files not found. Running build.bat first...
    call build.bat
    if %errorlevel% neq 0 (
        echo ERROR: Build failed!
        pause
        exit /b %errorlevel%
    )
)

REM Compile the parser
echo Compiling parser...
javac -cp "%CUP_JAR%" *.java
if %errorlevel% neq 0 (
    echo ERROR: Compilation failed!
    pause
    exit /b %errorlevel%
)

echo.
echo ========================================
echo Testing Example Programs
echo ========================================
echo.

REM Test each example program
for %%f in (examples\*.simpl) do (
    echo.
    echo ========================================
    echo Testing: %%f
    echo ========================================
    echo.
    java -cp ".;%CUP_JAR%" Main "%%f"
    echo.
    echo ========================================
    echo End of %%f
    echo ========================================
    echo.
    pause
)

echo.
echo ========================================
echo All examples tested successfully!
echo ========================================
echo.
pause 