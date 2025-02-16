structure RPL0Vals = RationLrValsFun(
structure Token = LrParser.Token);
structure RPL0Lex =RationLexFun (
structure Tokens = RPL0Vals.Tokens);
structure RPL0Parser = JoinWithArg(
structure ParserData =RPL0Vals.ParserData
structure Lex=RPL0Lex
structure LrParser=LrParser);