structure Tokens = Tokens
fun f(a)= let val s  = String.substring(a,1,String.size(a)-2); val s1 = String.tokens(fn c=> c = #"," ) s in (hd(s1),hd(tl(s1))) end 
type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult= (svalue,pos) token
val pos = ref 0
val eof = fn () => Tokens.EOF(!pos,!pos)
val error = fn (e,l : int,_) =>
              TextIO.output(TextIO.stdOut,"line " ^ (Int.toString(l)) ^
                               ": " ^ e ^ "\n")
%%
%header (functor CalcLexFun(structure Tokens: Calc_TOKENS));
digit=[0-9];
ws = [\ \t];
sign = "~"|"+";
bigint = [sign]{digit}+;
decimal = [sign]{digit}*"."{digit}*"("{digit}+")";
rational= "("[sign]bigint","[sign]bigint")";
%%
\n       => (pos := (!pos) + 1; lex());
{ws}+    => (lex());
{bigint}     => (Tokens.BIGINT(yytext,!pos,!pos));
{decimal}      => (Tokens.DECIMAL(yytext,!pos,!pos));
{rational}     => (Tokens.RATIONAL( valOf(Rational.make_rat(f(yytext))),!pos,!pos));
"+"      => (Tokens.PLUS(!pos,!pos));
"*"      => (Tokens.TIMES(!pos,!pos));
";"      => (Tokens.SEMI(!pos,!pos));
"-"      => (Tokens.SUB(!pos,!pos));
"/"      => (Tokens.DIV(!pos,!pos));
"."      => (error ("ignoring bad character "^yytext,!pos,!pos);
             lex());






