
open DataTypes
val typeTable : (string, Type) HashTable.hash_table =
    HashTable.mkTable (HashString.hashString, op=) (42, Fail "identifier not found") ;

exception VariableRedeclarationException of string ;
exception TypeMisMatchException ; 
exception UnDeclaredVariableException ;

fun insertInTable( idList :string list, idType : Type) = 
    if ( null idList ) then () else ( if isSome (HashTable.find typeTable (hd idList)) then raise VariableRedeclarationException( hd idList ) else
            HashTable.insert typeTable ( hd idList, idType ) ; insertInTable ( tl idList, idType) );

fun checkIntofID( id: string) = 
    if( isSome (HashTable.find typeTable id))
    then 
        case ( HashTable.lookup typeTable id ) of Int => () | Bool => ( raise TypeMisMatchException) | rational => ( raise TypeMisMatchException)
    else
        raise UnDeclaredVariableException ;

fun checkBoolofID( id : string ) =
    if( isSome (HashTable.find typeTable id))
    then 
        case ( HashTable.lookup typeTable id ) of Int => ( raise TypeMisMatchException) | Bool => () | rational => ( raise TypeMisMatchException)
    else
        raise UnDeclaredVariableException ; 

fun checkrationalofID( id : string ) =
    if( isSome (HashTable.find typeTable id))
    then 
        case ( HashTable.lookup typeTable id ) of Int => ( raise TypeMisMatchException) | Bool => (raise TypeMisMatchException) | rational => ()
    else
        raise UnDeclaredVariableException ;   

fun getType ( id : string ) = 
    if( isSome (HashTable.find typeTable id))
    then 
        HashTable.lookup typeTable id
    else 
        raise UnDeclaredVariableException ;

fun checkBool (typeToBeChecked : Type) = 
    if ( typeToBeChecked = Bool ) then true else false ;

fun checkInt (typeToBeChecked : Type) =
    if ( typeToBeChecked = Int ) then true else false ;

fun checkrational (typeToBeChecked : Type) =
    if ( typeToBeChecked = rational ) then true else false ;
 
fun checkSameType ( A : Type , B : Type ) = (A = B);


%%
%name Ration

%term  TOKEN_PLUS | TOKEN_UMINUS | TOKEN_MINUS | TOKEN_MULTIPLY | TOKEN_DIVIDE | TOKEN_MOD | TOKEN_EQUAL | TOKEN_NE | TOKEN_GT | TOKEN_GTE | TOKEN_LT | TOKEN_LTE | TOKEN_AND | TOKEN_OR | TOKEN_NOT | TOKEN_ASSIGN  | TOKEN_VAR | TOKEN_INTEGER | TOKEN_BOOL | TOKEN_READ | TOKEN_WRITE | TOKEN_IF | TOKEN_THEN | TOKEN_ELSE | TOKEN_ENDIF | TOKEN_WHILE | TOKEN_DO | TOKEN_OD | TOKEN_TT | TOKEN_FF  | TOKEN_SEMICOLON | TOKEN_COMMA | TOKEN_LBRACE | TOKEN_RBRACE | TOKEN_LPAREN | TOKEN_RPAREN | TOKEN_IDENT of string | TOKEN_NUM of string | TOKEN_EOF | TOKEN_SHOW_RAT | TOKEN_MAKE_RAT | TOKEN_LCOMMENT | TOKEN_RCOMMENT | TOKEN_SHOW_DECIMAL | TOKEN_TO_DECIMAL | TOKEN_FI | TOKEN_RPLUS | TOKEN_RMINUS | TOKEN_RMULTIPLY | TOKEN_RDIVIDE | TOKEN_INVERSE | TOKEN_RATIONAL | TOKEN_CALL | TOKEN_PROCEDURE | TOKEN_PRINT | TOKEN_RAT | TOKEN_BLOCK | TOKEN_R of string*string 

%nonterm start of DataTypes.AST | blk of DataTypes.BLK | decseq of DataTypes.DECSEQ | cmdseq of DataTypes.CMD list | commands of DataTypes.CMD list | command of DataTypes.CMD | typedec of DataTypes.Type | varlist of string list | expr of  DataTypes.Type*DataTypes.EXPR | procdec of DataTypes.PROCDEC | procdef of DataTypes.PROCDEF | procdeclist of DataTypes.PROCDEC list | vardec of DataTypes.VARDEC  

%pos int
%eop TOKEN_EOF 
%noshift TOKEN_EOF
%nodefault
%verbose

%right TOKEN_ASSIGN
%left TOKEN_OR
%left TOKEN_AND
%left TOKEN_EQUAL TOKEN_NE 
%left TOKEN_LTE TOKEN_LT TOKEN_GTE TOKEN_GT 
%left TOKEN_PLUS TOKEN_MINUS TOKEN_RPLUS TOKEN_RMINUS 
%left TOKEN_MULTIPLY TOKEN_DIVIDE TOKEN_MOD TOKEN_RMULTIPLY TOKEN_RDIVIDE
%left TOKEN_RAT TOKEN_MAKE_RAT TOKEN_SHOW_DECIMAL TOKEN_TO_DECIMAL TOKEN_INVERSE TOKEN_SHOW_RAT
%right TOKEN_UMINUS TOKEN_NOT 
%left TOKEN_LPAREN TOKEN_RPAREN

%arg (filename): string

%%

start: blk (HashTable.clear typeTable ; DataTypes.PROG(blk))
blk: decseq cmdseq (DataTypes.BLK(decseq,cmdseq))
decseq: vardec procdec  (DataTypes.DECSEQ(SOME vardec,SOME procdec)) | vardec (DataTypes.DECSEQ(SOME vardec,NONE)) | procdec (DataTypes.DECSEQ(NONE,SOME procdec)) | (DataTypes.DECSEQ(NONE,NONE))

procdec: procdef TOKEN_SEMICOLON procdeclist (DataTypes.PROCDEC( procdef,procdeclist)) 
procdeclist: procdec TOKEN_SEMICOLON procdeclist (procdec :: procdeclist )  | (([]))
procdef: TOKEN_PROCEDURE TOKEN_IDENT blk (DataTypes.PROCDEF (TOKEN_IDENT, blk)) 

vardec: typedec varlist TOKEN_SEMICOLON (( insertInTable( varlist , typedec) ; DataTypes.VARDEC(varlist ,typedec))) 
varlist: TOKEN_IDENT (([TOKEN_IDENT])) | TOKEN_IDENT TOKEN_COMMA varlist ((TOKEN_IDENT::varlist)) 
typedec: TOKEN_INTEGER ((Int)) | TOKEN_BOOL ((Bool)) | TOKEN_RATIONAL ((rational))
cmdseq: TOKEN_LBRACE commands TOKEN_RBRACE ((commands))
commands: command TOKEN_SEMICOLON commands ((command::commands)) | (([]))

command: TOKEN_READ TOKEN_IDENT ((DataTypes.RD(TOKEN_IDENT))) | TOKEN_PRINT TOKEN_IDENT ((DataTypes.PR(TOKEN_IDENT)))
        | TOKEN_IDENT TOKEN_ASSIGN expr (( if (checkSameType( getType TOKEN_IDENT, #1 expr)) then () else raise TypeMisMatchException; DataTypes.SET(TOKEN_IDENT,  #2 expr )))
        | TOKEN_CALL TOKEN_IDENT ((DataTypes.CL(TOKEN_IDENT)))
        | TOKEN_IF expr TOKEN_THEN cmdseq TOKEN_ELSE cmdseq TOKEN_ENDIF (( if (checkBool (#1 expr)) then () else raise TypeMisMatchException ; DataTypes.ITE( #2 expr, cmdseq, cmdseq)))
        | TOKEN_WHILE expr TOKEN_DO cmdseq TOKEN_OD (( if (checkBool (#1 expr)) then () else raise TypeMisMatchException ; DataTypes.WH( #2 expr, cmdseq )))

expr:  TOKEN_IDENT (( getType TOKEN_IDENT , IDENT(TOKEN_IDENT))) | TOKEN_LPAREN expr TOKEN_RPAREN ((expr)) 
        | expr TOKEN_PLUS expr (( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.ADD(#2 expr1 , #2 expr2))))
        | expr TOKEN_MINUS expr (( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.SUB(#2 expr1 , #2 expr2))))
        | expr TOKEN_MULTIPLY expr ((if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ; (Int , DataTypes.MUL(#2 expr1 , #2 expr2))))
        | expr TOKEN_DIVIDE expr (( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.DIV(#2 expr1 , #2 expr2))))
        | expr TOKEN_MOD expr (( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.MOD(#2 expr1 , #2 expr2))))
        | TOKEN_NUM (( Int , DataTypes.NUM(TOKEN_NUM) ))
        | expr TOKEN_RPLUS expr (( if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ;(rational , DataTypes.RADD(#2 expr1 , #2 expr2))))
        | expr TOKEN_RMINUS expr (( if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ;(rational , DataTypes.RSUB(#2 expr1 , #2 expr2))))
        | expr TOKEN_RMULTIPLY expr ((if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ; (rational , DataTypes.RMUL(#2 expr1 , #2 expr2))))
        | expr TOKEN_RDIVIDE expr (( if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ;(rational , DataTypes.RDIV(#2 expr1 , #2 expr2))))
        | TOKEN_UMINUS expr ((if checkrational(#1 expr) then () else raise TypeMisMatchException ;(rational , DataTypes.RUMINUS( #2 expr))))
        | TOKEN_R (( rational, DataTypes.R(TOKEN_R) ))
        | expr TOKEN_LTE expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.LTE( #2 expr1, #2 expr2))))
        | expr TOKEN_LT expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.LT( #2 expr1, #2 expr2))))
        | expr TOKEN_GTE expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.GTE( #2 expr1, #2 expr2))))
        | expr TOKEN_GT expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.GT( #2 expr1, #2 expr2))))
        | expr TOKEN_EQUAL expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.EQ( #2 expr1, #2 expr2))))
        | expr TOKEN_NE expr (( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.NE( #2 expr1, #2 expr2))))
        | expr TOKEN_AND expr ((if checkBool( #1  expr1) andalso checkBool( #1 expr2) then () else raise TypeMisMatchException ;(Bool , DataTypes.AND(#2 expr1 , #2 expr2))))
        | expr TOKEN_OR expr ((if checkBool( #1  expr1) andalso checkBool( #1 expr2) then () else raise TypeMisMatchException ;(Bool , DataTypes.OR(#2 expr1 , #2 expr2))))
        | TOKEN_NOT expr ((if checkBool( #1  expr) then () else raise TypeMisMatchException ;(Bool , DataTypes.NOT(#2 expr))))
        | TOKEN_TT ((Bool,TRUE))
        | TOKEN_FF ((Bool,FALSE))






