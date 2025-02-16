structure DataTypes=
    struct 
    type IDENT = string
    datatype VALUE = INTVAL of int | BOOLVAL of bool    
    datatype AST  = PROG of BLK
    and     BLK = BLK of DECSEQ * CMD list
    and     DECSEQ = DECSEQ of VARDEC option * PROCDEC option
    and     VARDEC = VARDEC of  ((string list) * Type) 
    and     Type = Int | Bool  | rational 
    and     PROCDEC = PROCDEC of PROCDEF*PROCDEC list
    and     PROCDEF = PROCDEF of string * BLK
    and     CMD   = SET of string*EXPR | RD of string | PR of string | CL of string | ITE of EXPR*(CMD list)*(CMD list) | WH of EXPR*(CMD list)
    and     EXPR =  IDENT of string | ADD of EXPR*EXPR | SUB of EXPR*EXPR | MUL of EXPR*EXPR | DIV of EXPR*EXPR | MOD of EXPR*EXPR |NUM of string | UMINUS of EXPR |  LT of EXPR*EXPR | GT of EXPR*EXPR | GTE of EXPR*EXPR |LTE of EXPR*EXPR | EQ of EXPR*EXPR | NE of EXPR*EXPR | AND of EXPR*EXPR | OR of EXPR*EXPR | NOT of EXPR | TRUE | FALSE | RADD of EXPR*EXPR | RSUB of EXPR*EXPR | RMUL of EXPR*EXPR | RDIV of EXPR*EXPR | RINV of EXPR | MAKE_RAT of EXPR | SHOW_RAT of EXPR | RAT of EXPR | TO_DECIMAL of EXPR | SHOW_DECIMAL of EXPR  |R of string*string | RUMINUS of EXPR
    exception SemanticError;
    end

