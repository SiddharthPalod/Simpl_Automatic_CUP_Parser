#!/bin/bash

echo "========================================"
echo "Cleaning generated and compiled files"
echo "========================================"
echo ""

# Remove generated Java files
if [ -f "SimplLexer.java" ]; then
    echo "Removing SimplLexer.java (generated from simpl.flex)..."
    rm -f SimplLexer.java
fi

if [ -f "SimplParser.java" ]; then
    echo "Removing SimplParser.java (generated from simpl.cup)..."
    rm -f SimplParser.java
fi

if [ -f "sym.java" ]; then
    echo "Removing sym.java (generated from simpl.cup)..."
    rm -f sym.java
fi

# Remove compiled class files
echo "Removing compiled .class files..."
rm -f *.class

# Remove backup files if any
if [ -f "SimplLexer.java~" ]; then
    echo "Removing backup file SimplLexer.java~..."
    rm -f SimplLexer.java~
fi

echo ""
echo "========================================"
echo "Clean completed!"
echo "========================================"
echo ""
echo "Removed files:"
echo "  - SimplLexer.java (can be regenerated with: ./build.sh)"
echo "  - SimplParser.java (can be regenerated with: ./build.sh)"
echo "  - sym.java (can be regenerated with: ./build.sh)"
echo "  - All .class files (can be regenerated with: ./build.sh)"
echo ""

