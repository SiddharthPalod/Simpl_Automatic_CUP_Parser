# SIMPL Parser - Distribution Package

## Files Included

- `simpl.flex` - JFlex lexer specification  
- `simpl.cup` - CUP grammar specification
- `Main.java` - Main program entry point
- `examples/` - Sample SIMPL programs
- `build.bat` - Windows build script
- `build.sh` - Linux/Mac build script

## Prerequisites

1. **Java JDK** (Java 8 or later)
2. **JFlex** - Download from https://www.jflex.de/
   - Extract and note the path to `jflex-full-*.jar`
3. **Java CUP** - Download from http://www2.cs.tum.edu/projects/cup/
   - Extract and note the path to `java-cup-11b.jar`

## Building

### Option 1: Using Build Scripts

**Windows:**
```cmd
set JFLEX_JAR=C:\path\to\jflex-full-1.9.1.jar
set CUP_JAR=C:\path\to\java-cup-11b.jar
build.bat
```

**Linux/Mac:**
```bash
export JFLEX_JAR=/path/to/jflex-full-1.9.1.jar
export CUP_JAR=/path/to/java-cup-11b.jar
bash build.sh
```

### Option 2: Manual Build

```bash
# 1. Generate lexer from JFlex
java -jar /path/to/jflex-full-1.9.1.jar simpl.flex

# 2. Generate parser from CUP
java -jar /path/to/java-cup-11b.jar -parser SimplParser -symbols sym simpl.cup

# 3. Compile all Java files
javac -cp /path/to/java-cup-11b.jar *.java
```

## Running

```bash
java -cp "/path/to/java-cup-11b.jar:." Main examples/01_simple_assignments.simpl
```

**Windows:**
```cmd
java -cp "C:\path\to\java-cup-11b.jar;." Main examples\01_simple_assignments.simpl
```

## What Gets Generated

After building, these files will be created:
- `SimplLexer.java` - Generated lexer (from simpl.flex)
- `SimplParser.java` - Generated parser (from simpl.cup)
- `sym.java` - Symbol constants (from simpl.cup)
- `*.class` - Compiled bytecode

## Quick Start

1. Download JFlex and CUP JARs
2. Set environment variables or update paths in build scripts
3. Run `build.bat` (Windows) or `bash build.sh` (Linux/Mac)
4. Test: `java -cp "java-cup-11b.jar;." Main examples/01_simple_assignments.simpl`
