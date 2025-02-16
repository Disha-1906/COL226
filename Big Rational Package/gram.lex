
%%

%eop EOF SEMI
%pos int

%left SUB PLUS
%left TIMES DIV


%term  BIGINT of bigint | RATIONAL of rational| DECIMAL of string | PLUS | TIMES | PRINT |
      SEMI | EOF | DIV | SUB | LPAREN | RPAREN
%nonterm EXP of rational | START of rational option

%name Calc


%prefer PLUS TIMES DIV SUB
%keyword  PRINT SEMI

%noshift EOF
%nodefault
%verbose
%%

(* the parser returns the value associated with the expression *)

  START : EXP (SOME EXP)
        | (NONE)
  EXP : BIGINT             (valOf(Rational.rat(BIGINT)))
      | RATIONAL		(valOf(Rational.make_rat(#1(RATIONAL),#2(RATIONAL))))
      | DECIMAL			(Rational.fromDecimal(DECIMAL))
      | EXP PLUS EXP    (Rational.add(EXP1,EXP2))
      | EXP TIMES EXP   (Rational.multiply(EXP1,EXP2))
      | EXP DIV EXP     (valOf(Rational.divide(EXP1,EXP2)))
      | EXP SUB EXP     (Rational.subtract(EXP1,EXP2))       
                    
