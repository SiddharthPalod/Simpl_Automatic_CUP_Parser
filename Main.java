import java.io.*;
import java.util.*;
import java_cup.runtime.Symbol;

public class Main {
    public static void main(String[] args) throws Exception {
        if (args.length != 1) {
            System.err.println("Usage: java Main <sourcefile.simpl>");
            System.exit(1);
        }

        // Read the input file
        BufferedReader reader = new BufferedReader(new FileReader(args[0]));
        StringBuilder content = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            content.append(line).append("\n");
        }
        reader.close();
        
        String input = content.toString();
        System.out.println("=== INPUT PROGRAM ===");
        System.out.println(input);
        
        // Create lexer using JFlex-generated SimplLexer
        SimplLexer lexer = new SimplLexer(new StringReader(input));
        
        // Print tokens for debugging
        System.out.println("\n=== TOKENS ===");
        List<String> tokenList = new ArrayList<>();
        Symbol token;
        SimplLexer debugLexer = new SimplLexer(new StringReader(input));
        while ((token = debugLexer.next_token()).sym != sym.EOF) {
            String tokenName = sym.terminalNames[token.sym];
            String tokenValue = token.value != null ? token.value.toString() : "";
            tokenList.add(tokenName + (tokenValue.isEmpty() ? "" : "(" + tokenValue + ")"));
        }
        System.out.println(tokenList);
        
        // Create parser using CUP-generated SimplParser
        // Reset lexer for parsing
        lexer = new SimplLexer(new StringReader(input));
        SimplParser parser = new SimplParser(lexer);
        
        try {
            // Parse the input using CUP parser
            Symbol result = parser.parse();
            
            System.out.println("\n=== PARSING SUCCESSFUL ===");
            System.out.println("\n=== AST ===");
            if (result != null && result.value != null) {
                System.out.println(result.value);
            }
            System.out.println("\n=== PRETTY PRINTED CODE ===");
            prettyPrint(input);
        } catch (Exception e) {
            System.out.println("\n=== PARSING FAILED ===");
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void prettyPrint(String input) {
        // Simple pretty printing by cleaning up the input
        String[] lines = input.split("\n");
        int indent = 0;
        
        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty()) continue;
            
            // Decrease indent for closing keywords
            if (line.equalsIgnoreCase("END") || 
                line.equalsIgnoreCase("FI") || 
                line.equalsIgnoreCase("DONE")) {
                indent = Math.max(0, indent - 1);
            }
            
            // Print with proper indentation
            String indentStr = "";
            for (int i = 0; i < indent; i++) {
                indentStr += "  ";
            }
            System.out.println(indentStr + line);
            
            // Increase indent for opening keywords
            if (line.equalsIgnoreCase("BEGIN") || 
                line.equalsIgnoreCase("THEN") || 
                line.equalsIgnoreCase("ELSE") || 
                line.equalsIgnoreCase("DO")) {
                indent++;
            }
        }
    }
}
