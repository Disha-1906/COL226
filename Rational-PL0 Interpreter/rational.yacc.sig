signature Ration_TOKENS =
sig
type ('a,'b) token
type svalue
val TOKEN_R: (string*string) *  'a * 'a -> (svalue,'a) token
val TOKEN_BLOCK:  'a * 'a -> (svalue,'a) token
val TOKEN_RAT:  'a * 'a -> (svalue,'a) token
val TOKEN_PRINT:  'a * 'a -> (svalue,'a) token
val TOKEN_PROCEDURE:  'a * 'a -> (svalue,'a) token
val TOKEN_CALL:  'a * 'a -> (svalue,'a) token
val TOKEN_RATIONAL:  'a * 'a -> (svalue,'a) token
val TOKEN_INVERSE:  'a * 'a -> (svalue,'a) token
val TOKEN_RDIVIDE:  'a * 'a -> (svalue,'a) token
val TOKEN_RMULTIPLY:  'a * 'a -> (svalue,'a) token
val TOKEN_RMINUS:  'a * 'a -> (svalue,'a) token
val TOKEN_RPLUS:  'a * 'a -> (svalue,'a) token
val TOKEN_FI:  'a * 'a -> (svalue,'a) token
val TOKEN_TO_DECIMAL:  'a * 'a -> (svalue,'a) token
val TOKEN_SHOW_DECIMAL:  'a * 'a -> (svalue,'a) token
val TOKEN_RCOMMENT:  'a * 'a -> (svalue,'a) token
val TOKEN_LCOMMENT:  'a * 'a -> (svalue,'a) token
val TOKEN_MAKE_RAT:  'a * 'a -> (svalue,'a) token
val TOKEN_SHOW_RAT:  'a * 'a -> (svalue,'a) token
val TOKEN_EOF:  'a * 'a -> (svalue,'a) token
val TOKEN_NUM: (string) *  'a * 'a -> (svalue,'a) token
val TOKEN_IDENT: (string) *  'a * 'a -> (svalue,'a) token
val TOKEN_RPAREN:  'a * 'a -> (svalue,'a) token
val TOKEN_LPAREN:  'a * 'a -> (svalue,'a) token
val TOKEN_RBRACE:  'a * 'a -> (svalue,'a) token
val TOKEN_LBRACE:  'a * 'a -> (svalue,'a) token
val TOKEN_COMMA:  'a * 'a -> (svalue,'a) token
val TOKEN_SEMICOLON:  'a * 'a -> (svalue,'a) token
val TOKEN_FF:  'a * 'a -> (svalue,'a) token
val TOKEN_TT:  'a * 'a -> (svalue,'a) token
val TOKEN_OD:  'a * 'a -> (svalue,'a) token
val TOKEN_DO:  'a * 'a -> (svalue,'a) token
val TOKEN_WHILE:  'a * 'a -> (svalue,'a) token
val TOKEN_ENDIF:  'a * 'a -> (svalue,'a) token
val TOKEN_ELSE:  'a * 'a -> (svalue,'a) token
val TOKEN_THEN:  'a * 'a -> (svalue,'a) token
val TOKEN_IF:  'a * 'a -> (svalue,'a) token
val TOKEN_WRITE:  'a * 'a -> (svalue,'a) token
val TOKEN_READ:  'a * 'a -> (svalue,'a) token
val TOKEN_BOOL:  'a * 'a -> (svalue,'a) token
val TOKEN_INTEGER:  'a * 'a -> (svalue,'a) token
val TOKEN_VAR:  'a * 'a -> (svalue,'a) token
val TOKEN_ASSIGN:  'a * 'a -> (svalue,'a) token
val TOKEN_NOT:  'a * 'a -> (svalue,'a) token
val TOKEN_OR:  'a * 'a -> (svalue,'a) token
val TOKEN_AND:  'a * 'a -> (svalue,'a) token
val TOKEN_LTE:  'a * 'a -> (svalue,'a) token
val TOKEN_LT:  'a * 'a -> (svalue,'a) token
val TOKEN_GTE:  'a * 'a -> (svalue,'a) token
val TOKEN_GT:  'a * 'a -> (svalue,'a) token
val TOKEN_NE:  'a * 'a -> (svalue,'a) token
val TOKEN_EQUAL:  'a * 'a -> (svalue,'a) token
val TOKEN_MOD:  'a * 'a -> (svalue,'a) token
val TOKEN_DIVIDE:  'a * 'a -> (svalue,'a) token
val TOKEN_MULTIPLY:  'a * 'a -> (svalue,'a) token
val TOKEN_MINUS:  'a * 'a -> (svalue,'a) token
val TOKEN_UMINUS:  'a * 'a -> (svalue,'a) token
val TOKEN_PLUS:  'a * 'a -> (svalue,'a) token
end
signature Ration_LRVALS=
sig
structure Tokens : Ration_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
