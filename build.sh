#!/bin/bash

echo "========================================"
echo "Building SIMPL Parser with JFlex and CUP"
echo "========================================"
echo ""

# Set default paths if not provided
if [ -z "$JFLEX_JAR" ]; then
    echo "JFLEX_JAR environment variable not set, using default path..."
    JFLEX_JAR="ADD YOUR JFLEX JAR LOCATION HERE"
fi

# Check if JFlex jar exists
if [ ! -f "$JFLEX_JAR" ]; then
    echo "ERROR: JFlex jar not found at: $JFLEX_JAR"
    echo "Please set JFLEX_JAR environment variable to the path of jflex-full-*.jar"
    echo "Example: export JFLEX_JAR=/path/to/jflex-full-1.9.1.jar"
    echo "Download JFlex from https://www.jflex.de/"
    exit 1
fi

# Set default paths if not provided
if [ -z "$CUP_JAR" ]; then
    echo "CUP_JAR environment variable not set, using default path..."
    CUP_JAR="ADD YOUR CUP JAR LOCATION HERE"
fi

# Check if CUP jar exists
if [ ! -f "$CUP_JAR" ]; then
    echo "ERROR: CUP jar not found at: $CUP_JAR"
    echo "Please set CUP_JAR environment variable to the path of java-cup-*.jar"
    echo "Example: export CUP_JAR=/path/to/java-cup-11b.jar"
    echo "Download Java CUP from http://www2.cs.tum.edu/projects/cup/"
    exit 1
fi

echo "Step 1: Generating lexer from simpl.flex..."
java -jar "$JFLEX_JAR" simpl.flex
if [ $? -ne 0 ]; then
    echo "ERROR: JFlex generation failed!"
    exit 1
fi

echo "Step 2: Generating parser from simpl.cup..."
java -jar "$CUP_JAR" -parser SimplParser -symbols sym simpl.cup
if [ $? -ne 0 ]; then
    echo "ERROR: CUP generation failed!"
    exit 1
fi

echo "Step 3: Compiling all Java files..."
javac -cp "$CUP_JAR" *.java
if [ $? -ne 0 ]; then
    echo "ERROR: Compilation failed!"
    exit 1
fi

echo ""
echo "========================================"
echo "SUCCESS: Build completed!"
echo "========================================"
echo "Generated files:"
echo "  - SimplLexer.java (from JFlex)"
echo "  - SimplParser.java (from CUP)"
echo "  - sym.java (from CUP - already existed)"
echo ""
