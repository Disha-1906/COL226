--------------------------------------------------------------GRAMMAR------------------------------------------------------------------
start : blk
blk : decseq cmdseq
decseq : [vardec][prodec]
procdec : prodef ; {procdec ;} ;
procdef : procedure Ident blk
vardec : typedec Ident { , Ident} ; 
typedec : Int | Bool | rational
cmdseq : {{command ; }}
command : read Ident | print Ident | Ident := expression | call Ident | If expression then cmdseq else cmdseq fi | while expression do cmdseq od 
expression : Ident | (expression) | expression + expression | expression - expression | expression * expression | expression / expression | expression % expression | {digit} | ~ expression | rational | expression and expression | expression or expression | ! expression | tt | ff
            | expression .+. expression | expression .-. expression | expression .*. expression | expression ./. expression | expression > expression | expression < expression | expression <> expression | expression <= expression | expression >= expression | expression = expression
            | make_rat (expression) | show_rat(expression) | rat(expression)




-----------------------------------------------------------PARSING STRATEGIES----------------------------------------------------------
This is a ML-Yacc specification file that defines a parser for a programming language. I have used ML-YACC tool for parsing. The grammar specification includes several parsing techniques, including:

1. Terminal symbols: The grammar includes definitions for various terminal symbols such as TOKEN_PLUS, TOKEN_MINUS, TOKEN_EQUAL, TOKEN_LPAREN, TOKEN_RPAREN, etc. These symbols are used to define the tokens that are recognized by the lexer.

2. Nonterminal symbols: The grammar also includes definitions for nonterminal symbols such as start, blk, decseq, cmdseq, commands, command, typedec, varlist, expr, procdec, procdef, procdeclist, vardec, etc. These nonterminal symbols are used to define the various syntactic categories of the language.

3. Precedence rules: The grammar includes precedence rules for the various operators in the language. For example, the binary operators "+" and "-" have the same precedence level and are left-associative, while the unary operators "-" and "not" have a higher precedence level than the binary operators.

4. Semantic actions: The grammar includes semantic actions that are executed when certain productions are parsed. For example, the production "procdef: TOKEN_PROCEDURE TOKEN_IDENT blk" includes a semantic action that creates a PROCDEF node in the AST.

5. Error handling: The grammar includes error handling rules that dictate how the parser should recover from syntax errors. For example, the %nodefault directive specifies that the parser should not generate default error messages when it encounters an unexpected token.

6. Symbol table management: The grammar includes functions for managing a symbol table, such as inserting entries into the table, looking up entries in the table, and checking the type of an entry. These functions are used to perform semantic analysis of the input program.

7. Exceptions - VariableRedeclarationException, Type MismatchException, UndeclaredvariableException are raised when necessary.

8. Typechecking has also been included. Functions have been defined to check same type , checking specific type and getting type from symbol table have been defined. Before passing any expression for making AST, types of the operators have been checked wherever needed.