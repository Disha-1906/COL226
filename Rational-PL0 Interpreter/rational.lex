
structure T = Tokens

type pos = int
type svalue = T.svalue
type ('a, 'b) token = ('a, 'b) T.token
type lexresult = (svalue,pos) token
type lexarg = string
type arg = lexarg

val line_num = ref 1;
val col_num = ref 0;
val eolpos = ref 0;

val  eof = fn filename => (line_num := 1; col_num := 0; T.TOKEN_EOF (!line_num , !col_num));
fun increase a  = a := !a + 1;

%%
%header (functor RationLexFun (structure Tokens : Ration_TOKENS)); 
%arg (filename: string);
alpha=[A-Za-z];
digit=[0-9];
nz=[1-9];
sign=[~+];
rati=[sign]{digit}* | [sign]{digit}*[.]{digit}*[(]{digit}+[)] | [(][sign]{digit}+[,]{digit}nz{digit}[)];
ws = [\ \t];
eol = ("\013\010" | "\010" | "\013");
%%
{ws}* => (continue ());
{eol} => (increase line_num; eolpos := yypos+size yytext; continue ());
"while" => (col_num:=yypos-(!eolpos); T.TOKEN_WHILE(!line_num,!col_num));
"if" => (col_num:=yypos-(!eolpos); T.TOKEN_IF(!line_num,!col_num));
"then" => (col_num:=yypos-(!eolpos); T.TOKEN_THEN(!line_num,!col_num));
"else" => (col_num:=yypos-(!eolpos); T.TOKEN_ELSE(!line_num,!col_num));
"fi" => (col_num:=yypos-(!eolpos); T.TOKEN_FI(!line_num,!col_num));
"od" => (col_num:=yypos-(!eolpos); T.TOKEN_OD(!line_num,!col_num));
"do" => (col_num:=yypos-(!eolpos); T.TOKEN_DO(!line_num,!col_num));
"read" => (col_num:=yypos-(!eolpos); T.TOKEN_READ(!line_num,!col_num));
"print" => (col_num:=yypos-(!eolpos); T.TOKEN_PRINT(!line_num,!col_num));
"call" => (col_num:=yypos-(!eolpos); T.TOKEN_CALL(!line_num,!col_num));
"procedure" => (col_num:=yypos-(!eolpos); T.TOKEN_PROCEDURE(!line_num,!col_num));
"integer" => (col_num:=yypos-(!eolpos); T.TOKEN_INTEGER(!line_num,!col_num));
"bool" => (col_num:=yypos-(!eolpos); T.TOKEN_BOOL(!line_num,!col_num));
"rational" => (col_num:=yypos-(!eolpos); T.TOKEN_RATIONAL(!line_num,!col_num));
"var" => (col_num:=yypos-(!eolpos); T.TOKEN_VAR(!line_num,!col_num));
"tt" => (col_num:=yypos-(!eolpos); T.TOKEN_TT(!line_num,!col_num));
"ff" => (col_num:=yypos-(!eolpos); T.TOKEN_FF(!line_num,!col_num));



"{" => (col_num:=yypos-(!eolpos); T.TOKEN_LBRACE(!line_num,!col_num));
"}" => (col_num:=yypos-(!eolpos); T.TOKEN_RBRACE(!line_num,!col_num));
"(" => (col_num:=yypos-(!eolpos); T.TOKEN_LPAREN(!line_num,!col_num));
")" => (col_num:=yypos-(!eolpos); T.TOKEN_RPAREN(!line_num,!col_num));
"," => (col_num:=yypos-(!eolpos); T.TOKEN_COMMA(!line_num,!col_num));
";" => (col_num:=yypos-(!eolpos); T.TOKEN_SEMICOLON(!line_num,!col_num));

".+." => (col_num:=yypos-(!eolpos); T.TOKEN_RPLUS(!line_num,!col_num));
".-." => (col_num:=yypos-(!eolpos); T.TOKEN_RMINUS(!line_num,!col_num));
".*." => (col_num:=yypos-(!eolpos); T.TOKEN_RMULTIPLY(!line_num,!col_num));
"./." => (col_num:=yypos-(!eolpos); T.TOKEN_RDIVIDE(!line_num,!col_num));
"inverse" => (col_num:=yypos-(!eolpos); T.TOKEN_INVERSE(!line_num,!col_num));

"+" => (col_num:=yypos-(!eolpos); T.TOKEN_PLUS(!line_num,!col_num));
"~" => (col_num:=yypos-(!eolpos); T.TOKEN_UMINUS(!line_num,!col_num));
"-" => (col_num:=yypos-(!eolpos); T.TOKEN_MINUS(!line_num,!col_num));
"*" => (col_num:=yypos-(!eolpos); T.TOKEN_MULTIPLY(!line_num,!col_num));
"/" => (col_num:=yypos-(!eolpos); T.TOKEN_DIVIDE(!line_num,!col_num));
"%" => (col_num:=yypos-(!eolpos); T.TOKEN_MOD(!line_num,!col_num));
"!" => (col_num:=yypos-(!eolpos); T.TOKEN_NOT(!line_num,!col_num));
":=" => (col_num:=yypos-(!eolpos); T.TOKEN_ASSIGN(!line_num,!col_num));

"=" => (col_num:=yypos-(!eolpos); T.TOKEN_EQUAL(!line_num,!col_num));
"<" => (col_num:=yypos-(!eolpos); T.TOKEN_GT(!line_num,!col_num));
">" => (col_num:=yypos-(!eolpos); T.TOKEN_LT(!line_num,!col_num));
"<=" => (col_num:=yypos-(!eolpos); T.TOKEN_LTE(!line_num,!col_num));
">=" => (col_num:=yypos-(!eolpos); T.TOKEN_GTE(!line_num,!col_num));
"<>" => (col_num:=yypos-(!eolpos); T.TOKEN_NE(!line_num,!col_num));
"||" => (col_num:=yypos-(!eolpos); T.TOKEN_OR(!line_num,!col_num));
"&&" => (col_num:=yypos-(!eolpos); T.TOKEN_AND(!line_num,!col_num));

"make_rat" => (col_num:=yypos-(!eolpos); T.TOKEN_MAKE_RAT(!line_num,!col_num));
"rat" => (col_num:=yypos-(!eolpos); T.TOKEN_RAT(!line_num,!col_num));
"showRat" => (col_num:=yypos-(!eolpos); T.TOKEN_SHOW_RAT(!line_num,!col_num));
"showDecimal" => (col_num:=yypos-(!eolpos); T.TOKEN_SHOW_DECIMAL(!line_num,!col_num));
"toDecimal" => (col_num:=yypos-(!eolpos); T.TOKEN_TO_DECIMAL(!line_num,!col_num));

"(*" => (col_num:=yypos-(!eolpos); T.TOKEN_LCOMMENT(!line_num,!col_num));
"*)" => (col_num:=yypos-(!eolpos); T.TOKEN_RCOMMENT(!line_num,!col_num));


([+]?)({digit}){digit}* => ( T.TOKEN_NUM( yytext , !line_num , !col_num ) ) ;

rati => (col_num:=yypos-(!eolpos); T.TOKEN_R(("",""),!line_num,!col_num));
[A-Za-z][A-Za-z0-9]* => (col_num:=yypos-(!eolpos);T.TOKEN_IDENT(yytext,!line_num,!col_num));

. => (print ("Unknown token found at " ^ (Int.toString (!line_num)) ^ ": <" ^ yytext ^ ">. Continuing.\n"); continue());