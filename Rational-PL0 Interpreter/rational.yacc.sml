functor RationLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Ration_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct

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



end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\126\000\003\000\126\000\004\000\126\000\005\000\126\000\
\\006\000\126\000\007\000\126\000\008\000\126\000\009\000\126\000\
\\010\000\126\000\011\000\126\000\012\000\126\000\013\000\126\000\
\\014\000\126\000\023\000\126\000\027\000\126\000\031\000\126\000\
\\036\000\126\000\047\000\126\000\048\000\126\000\049\000\126\000\
\\050\000\126\000\000\000\
\\001\000\001\000\127\000\003\000\127\000\004\000\127\000\005\000\127\000\
\\006\000\127\000\007\000\127\000\008\000\127\000\009\000\127\000\
\\010\000\127\000\011\000\127\000\012\000\127\000\013\000\127\000\
\\014\000\127\000\023\000\127\000\027\000\127\000\031\000\127\000\
\\036\000\127\000\047\000\127\000\048\000\127\000\049\000\127\000\
\\050\000\127\000\000\000\
\\001\000\001\000\128\000\003\000\128\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\128\000\008\000\128\000\009\000\128\000\
\\010\000\128\000\011\000\128\000\012\000\128\000\013\000\128\000\
\\014\000\128\000\023\000\128\000\027\000\128\000\031\000\128\000\
\\036\000\128\000\047\000\128\000\048\000\128\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\129\000\003\000\129\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\129\000\008\000\129\000\009\000\129\000\
\\010\000\129\000\011\000\129\000\012\000\129\000\013\000\129\000\
\\014\000\129\000\023\000\129\000\027\000\129\000\031\000\129\000\
\\036\000\129\000\047\000\129\000\048\000\129\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\130\000\003\000\130\000\004\000\130\000\005\000\130\000\
\\006\000\130\000\007\000\130\000\008\000\130\000\009\000\130\000\
\\010\000\130\000\011\000\130\000\012\000\130\000\013\000\130\000\
\\014\000\130\000\023\000\130\000\027\000\130\000\031\000\130\000\
\\036\000\130\000\047\000\130\000\048\000\130\000\049\000\130\000\
\\050\000\130\000\000\000\
\\001\000\001\000\131\000\003\000\131\000\004\000\131\000\005\000\131\000\
\\006\000\131\000\007\000\131\000\008\000\131\000\009\000\131\000\
\\010\000\131\000\011\000\131\000\012\000\131\000\013\000\131\000\
\\014\000\131\000\023\000\131\000\027\000\131\000\031\000\131\000\
\\036\000\131\000\047\000\131\000\048\000\131\000\049\000\131\000\
\\050\000\131\000\000\000\
\\001\000\001\000\132\000\003\000\132\000\004\000\132\000\005\000\132\000\
\\006\000\132\000\007\000\132\000\008\000\132\000\009\000\132\000\
\\010\000\132\000\011\000\132\000\012\000\132\000\013\000\132\000\
\\014\000\132\000\023\000\132\000\027\000\132\000\031\000\132\000\
\\036\000\132\000\047\000\132\000\048\000\132\000\049\000\132\000\
\\050\000\132\000\000\000\
\\001\000\001\000\133\000\003\000\133\000\004\000\133\000\005\000\133\000\
\\006\000\133\000\007\000\133\000\008\000\133\000\009\000\133\000\
\\010\000\133\000\011\000\133\000\012\000\133\000\013\000\133\000\
\\014\000\133\000\023\000\133\000\027\000\133\000\031\000\133\000\
\\036\000\133\000\047\000\133\000\048\000\133\000\049\000\133\000\
\\050\000\133\000\000\000\
\\001\000\001\000\134\000\003\000\134\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\134\000\008\000\134\000\009\000\134\000\
\\010\000\134\000\011\000\134\000\012\000\134\000\013\000\134\000\
\\014\000\134\000\023\000\134\000\027\000\134\000\031\000\134\000\
\\036\000\134\000\047\000\134\000\048\000\134\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\135\000\003\000\135\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\135\000\008\000\135\000\009\000\135\000\
\\010\000\135\000\011\000\135\000\012\000\135\000\013\000\135\000\
\\014\000\135\000\023\000\135\000\027\000\135\000\031\000\135\000\
\\036\000\135\000\047\000\135\000\048\000\135\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\136\000\003\000\136\000\004\000\136\000\005\000\136\000\
\\006\000\136\000\007\000\136\000\008\000\136\000\009\000\136\000\
\\010\000\136\000\011\000\136\000\012\000\136\000\013\000\136\000\
\\014\000\136\000\023\000\136\000\027\000\136\000\031\000\136\000\
\\036\000\136\000\047\000\136\000\048\000\136\000\049\000\136\000\
\\050\000\136\000\000\000\
\\001\000\001\000\137\000\003\000\137\000\004\000\137\000\005\000\137\000\
\\006\000\137\000\007\000\137\000\008\000\137\000\009\000\137\000\
\\010\000\137\000\011\000\137\000\012\000\137\000\013\000\137\000\
\\014\000\137\000\023\000\137\000\027\000\137\000\031\000\137\000\
\\036\000\137\000\047\000\137\000\048\000\137\000\049\000\137\000\
\\050\000\137\000\000\000\
\\001\000\001\000\138\000\003\000\138\000\004\000\138\000\005\000\138\000\
\\006\000\138\000\007\000\138\000\008\000\138\000\009\000\138\000\
\\010\000\138\000\011\000\138\000\012\000\138\000\013\000\138\000\
\\014\000\138\000\023\000\138\000\027\000\138\000\031\000\138\000\
\\036\000\138\000\047\000\138\000\048\000\138\000\049\000\138\000\
\\050\000\138\000\000\000\
\\001\000\001\000\139\000\003\000\139\000\004\000\139\000\005\000\139\000\
\\006\000\139\000\007\000\139\000\008\000\139\000\009\000\139\000\
\\010\000\139\000\011\000\139\000\012\000\139\000\013\000\139\000\
\\014\000\139\000\023\000\139\000\027\000\139\000\031\000\139\000\
\\036\000\139\000\047\000\139\000\048\000\139\000\049\000\139\000\
\\050\000\139\000\000\000\
\\001\000\001\000\148\000\003\000\148\000\004\000\148\000\005\000\148\000\
\\006\000\148\000\007\000\148\000\008\000\148\000\009\000\148\000\
\\010\000\148\000\011\000\148\000\012\000\148\000\013\000\148\000\
\\014\000\148\000\023\000\148\000\027\000\148\000\031\000\148\000\
\\036\000\148\000\047\000\148\000\048\000\148\000\049\000\148\000\
\\050\000\148\000\000\000\
\\001\000\001\000\149\000\003\000\149\000\004\000\149\000\005\000\149\000\
\\006\000\149\000\007\000\149\000\008\000\149\000\009\000\149\000\
\\010\000\149\000\011\000\149\000\012\000\149\000\013\000\149\000\
\\014\000\149\000\023\000\149\000\027\000\149\000\031\000\149\000\
\\036\000\149\000\047\000\149\000\048\000\149\000\049\000\149\000\
\\050\000\149\000\000\000\
\\001\000\001\000\150\000\003\000\150\000\004\000\150\000\005\000\150\000\
\\006\000\150\000\007\000\150\000\008\000\150\000\009\000\150\000\
\\010\000\150\000\011\000\150\000\012\000\150\000\013\000\150\000\
\\014\000\150\000\023\000\150\000\027\000\150\000\031\000\150\000\
\\036\000\150\000\047\000\150\000\048\000\150\000\049\000\150\000\
\\050\000\150\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\140\000\008\000\140\000\009\000\140\000\
\\010\000\140\000\011\000\140\000\012\000\140\000\013\000\140\000\
\\014\000\140\000\023\000\140\000\027\000\140\000\031\000\140\000\
\\036\000\140\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\141\000\008\000\141\000\009\000\141\000\
\\010\000\141\000\011\000\141\000\012\000\141\000\013\000\141\000\
\\014\000\141\000\023\000\141\000\027\000\141\000\031\000\141\000\
\\036\000\141\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\142\000\008\000\142\000\009\000\142\000\
\\010\000\142\000\011\000\142\000\012\000\142\000\013\000\142\000\
\\014\000\142\000\023\000\142\000\027\000\142\000\031\000\142\000\
\\036\000\142\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\143\000\008\000\143\000\009\000\143\000\
\\010\000\143\000\011\000\143\000\012\000\143\000\013\000\143\000\
\\014\000\143\000\023\000\143\000\027\000\143\000\031\000\143\000\
\\036\000\143\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\144\000\008\000\144\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\144\000\
\\014\000\144\000\023\000\144\000\027\000\144\000\031\000\144\000\
\\036\000\144\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\145\000\008\000\145\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\145\000\
\\014\000\145\000\023\000\145\000\027\000\145\000\031\000\145\000\
\\036\000\145\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\066\000\008\000\065\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\146\000\
\\014\000\146\000\023\000\146\000\027\000\146\000\031\000\146\000\
\\036\000\146\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\066\000\008\000\065\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\060\000\
\\014\000\147\000\023\000\147\000\027\000\147\000\031\000\147\000\
\\036\000\147\000\047\000\057\000\048\000\056\000\049\000\055\000\
\\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\066\000\008\000\065\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\060\000\
\\014\000\059\000\023\000\075\000\047\000\057\000\048\000\056\000\
\\049\000\055\000\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\066\000\008\000\065\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\060\000\
\\014\000\059\000\027\000\058\000\047\000\057\000\048\000\056\000\
\\049\000\055\000\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\066\000\008\000\065\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\060\000\
\\014\000\059\000\031\000\122\000\047\000\057\000\048\000\056\000\
\\049\000\055\000\050\000\054\000\000\000\
\\001\000\001\000\071\000\003\000\070\000\004\000\069\000\005\000\068\000\
\\006\000\067\000\007\000\066\000\008\000\065\000\009\000\064\000\
\\010\000\063\000\011\000\062\000\012\000\061\000\013\000\060\000\
\\014\000\059\000\036\000\094\000\047\000\057\000\048\000\056\000\
\\049\000\055\000\050\000\054\000\000\000\
\\001\000\002\000\048\000\015\000\047\000\029\000\046\000\030\000\045\000\
\\035\000\044\000\037\000\043\000\038\000\042\000\058\000\041\000\000\000\
\\001\000\016\000\039\000\000\000\
\\001\000\018\000\012\000\019\000\011\000\033\000\106\000\052\000\010\000\
\\054\000\009\000\000\000\
\\001\000\020\000\031\000\022\000\030\000\026\000\029\000\034\000\119\000\
\\037\000\028\000\053\000\027\000\055\000\026\000\000\000\
\\001\000\024\000\117\000\025\000\117\000\028\000\117\000\031\000\117\000\
\\039\000\117\000\000\000\
\\001\000\024\000\097\000\000\000\
\\001\000\025\000\099\000\000\000\
\\001\000\028\000\096\000\000\000\
\\001\000\031\000\102\000\039\000\102\000\000\000\
\\001\000\031\000\107\000\033\000\107\000\000\000\
\\001\000\031\000\108\000\033\000\108\000\000\000\
\\001\000\031\000\109\000\033\000\109\000\054\000\009\000\000\000\
\\001\000\031\000\110\000\000\000\
\\001\000\031\000\112\000\032\000\023\000\000\000\
\\001\000\031\000\113\000\000\000\
\\001\000\031\000\120\000\000\000\
\\001\000\031\000\121\000\000\000\
\\001\000\031\000\123\000\000\000\
\\001\000\031\000\124\000\000\000\
\\001\000\031\000\125\000\000\000\
\\001\000\031\000\014\000\000\000\
\\001\000\031\000\022\000\000\000\
\\001\000\031\000\033\000\000\000\
\\001\000\031\000\035\000\000\000\
\\001\000\033\000\103\000\000\000\
\\001\000\033\000\104\000\054\000\009\000\000\000\
\\001\000\033\000\105\000\000\000\
\\001\000\033\000\111\000\054\000\111\000\000\000\
\\001\000\033\000\018\000\000\000\
\\001\000\034\000\118\000\000\000\
\\001\000\034\000\036\000\000\000\
\\001\000\037\000\114\000\000\000\
\\001\000\037\000\115\000\000\000\
\\001\000\037\000\116\000\000\000\
\\001\000\037\000\016\000\000\000\
\\001\000\037\000\019\000\000\000\
\\001\000\037\000\037\000\000\000\
\\001\000\037\000\038\000\000\000\
\\001\000\037\000\050\000\000\000\
\\001\000\039\000\000\000\000\000\
\\001\000\039\000\101\000\000\000\
\"
val actionRowNumbers =
"\031\000\054\000\049\000\055\000\
\\063\000\057\000\069\000\064\000\
\\062\000\061\000\060\000\053\000\
\\040\000\050\000\042\000\037\000\
\\032\000\031\000\038\000\051\000\
\\056\000\063\000\052\000\059\000\
\\065\000\066\000\030\000\029\000\
\\029\000\067\000\041\000\040\000\
\\043\000\032\000\033\000\045\000\
\\046\000\029\000\026\000\013\000\
\\007\000\000\000\029\000\016\000\
\\015\000\029\000\029\000\025\000\
\\044\000\039\000\058\000\027\000\
\\029\000\029\000\029\000\029\000\
\\057\000\029\000\029\000\029\000\
\\029\000\029\000\029\000\029\000\
\\029\000\029\000\029\000\029\000\
\\029\000\029\000\028\000\014\000\
\\012\000\057\000\011\000\010\000\
\\009\000\008\000\036\000\024\000\
\\023\000\017\000\018\000\019\000\
\\020\000\022\000\021\000\006\000\
\\005\000\004\000\003\000\002\000\
\\001\000\034\000\048\000\057\000\
\\035\000\047\000\068\000"
val gotoT =
"\
\\001\000\098\000\002\000\006\000\003\000\005\000\007\000\004\000\
\\010\000\003\000\011\000\002\000\013\000\001\000\000\000\
\\010\000\011\000\011\000\002\000\000\000\
\\000\000\
\\000\000\
\\008\000\013\000\000\000\
\\004\000\015\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\019\000\011\000\002\000\012\000\018\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\023\000\006\000\022\000\000\000\
\\002\000\030\000\003\000\005\000\007\000\004\000\010\000\003\000\
\\011\000\002\000\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\032\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\038\000\000\000\
\\009\000\047\000\000\000\
\\000\000\
\\000\000\
\\010\000\019\000\011\000\002\000\012\000\049\000\000\000\
\\000\000\
\\005\000\050\000\006\000\022\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\051\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\070\000\000\000\
\\000\000\
\\000\000\
\\009\000\071\000\000\000\
\\009\000\072\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\074\000\000\000\
\\009\000\075\000\000\000\
\\009\000\076\000\000\000\
\\009\000\077\000\000\000\
\\004\000\078\000\000\000\
\\009\000\079\000\000\000\
\\009\000\080\000\000\000\
\\009\000\081\000\000\000\
\\009\000\082\000\000\000\
\\009\000\083\000\000\000\
\\009\000\084\000\000\000\
\\009\000\085\000\000\000\
\\009\000\086\000\000\000\
\\009\000\087\000\000\000\
\\009\000\088\000\000\000\
\\009\000\089\000\000\000\
\\009\000\090\000\000\000\
\\009\000\091\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\093\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\096\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 99
val numrules = 50
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = string
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | TOKEN_R of unit ->  (string*string)
 | TOKEN_NUM of unit ->  (string) | TOKEN_IDENT of unit ->  (string)
 | vardec of unit ->  (DataTypes.VARDEC)
 | procdeclist of unit ->  (DataTypes.PROCDEC list)
 | procdef of unit ->  (DataTypes.PROCDEF)
 | procdec of unit ->  (DataTypes.PROCDEC)
 | expr of unit ->  (DataTypes.Type*DataTypes.EXPR)
 | varlist of unit ->  (string list)
 | typedec of unit ->  (DataTypes.Type)
 | command of unit ->  (DataTypes.CMD)
 | commands of unit ->  (DataTypes.CMD list)
 | cmdseq of unit ->  (DataTypes.CMD list)
 | decseq of unit ->  (DataTypes.DECSEQ)
 | blk of unit ->  (DataTypes.BLK) | start of unit ->  (DataTypes.AST)
end
type svalue = MlyValue.svalue
type result = DataTypes.AST
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 38) => true | _ => false
val showTerminal =
fn (T 0) => "TOKEN_PLUS"
  | (T 1) => "TOKEN_UMINUS"
  | (T 2) => "TOKEN_MINUS"
  | (T 3) => "TOKEN_MULTIPLY"
  | (T 4) => "TOKEN_DIVIDE"
  | (T 5) => "TOKEN_MOD"
  | (T 6) => "TOKEN_EQUAL"
  | (T 7) => "TOKEN_NE"
  | (T 8) => "TOKEN_GT"
  | (T 9) => "TOKEN_GTE"
  | (T 10) => "TOKEN_LT"
  | (T 11) => "TOKEN_LTE"
  | (T 12) => "TOKEN_AND"
  | (T 13) => "TOKEN_OR"
  | (T 14) => "TOKEN_NOT"
  | (T 15) => "TOKEN_ASSIGN"
  | (T 16) => "TOKEN_VAR"
  | (T 17) => "TOKEN_INTEGER"
  | (T 18) => "TOKEN_BOOL"
  | (T 19) => "TOKEN_READ"
  | (T 20) => "TOKEN_WRITE"
  | (T 21) => "TOKEN_IF"
  | (T 22) => "TOKEN_THEN"
  | (T 23) => "TOKEN_ELSE"
  | (T 24) => "TOKEN_ENDIF"
  | (T 25) => "TOKEN_WHILE"
  | (T 26) => "TOKEN_DO"
  | (T 27) => "TOKEN_OD"
  | (T 28) => "TOKEN_TT"
  | (T 29) => "TOKEN_FF"
  | (T 30) => "TOKEN_SEMICOLON"
  | (T 31) => "TOKEN_COMMA"
  | (T 32) => "TOKEN_LBRACE"
  | (T 33) => "TOKEN_RBRACE"
  | (T 34) => "TOKEN_LPAREN"
  | (T 35) => "TOKEN_RPAREN"
  | (T 36) => "TOKEN_IDENT"
  | (T 37) => "TOKEN_NUM"
  | (T 38) => "TOKEN_EOF"
  | (T 39) => "TOKEN_SHOW_RAT"
  | (T 40) => "TOKEN_MAKE_RAT"
  | (T 41) => "TOKEN_LCOMMENT"
  | (T 42) => "TOKEN_RCOMMENT"
  | (T 43) => "TOKEN_SHOW_DECIMAL"
  | (T 44) => "TOKEN_TO_DECIMAL"
  | (T 45) => "TOKEN_FI"
  | (T 46) => "TOKEN_RPLUS"
  | (T 47) => "TOKEN_RMINUS"
  | (T 48) => "TOKEN_RMULTIPLY"
  | (T 49) => "TOKEN_RDIVIDE"
  | (T 50) => "TOKEN_INVERSE"
  | (T 51) => "TOKEN_RATIONAL"
  | (T 52) => "TOKEN_CALL"
  | (T 53) => "TOKEN_PROCEDURE"
  | (T 54) => "TOKEN_PRINT"
  | (T 55) => "TOKEN_RAT"
  | (T 56) => "TOKEN_BLOCK"
  | (T 57) => "TOKEN_R"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 56) $$ (T 55) $$ (T 54) $$ (T 53) $$ (T 52) $$ (T 51) $$ (T 50)
 $$ (T 49) $$ (T 48) $$ (T 47) $$ (T 46) $$ (T 45) $$ (T 44) $$ (T 43)
 $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38) $$ (T 35) $$ (T 34)
 $$ (T 33) $$ (T 32) $$ (T 31) $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27)
 $$ (T 26) $$ (T 25) $$ (T 24) $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20)
 $$ (T 19) $$ (T 18) $$ (T 17) $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13)
 $$ (T 12) $$ (T 11) $$ (T 10) $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ 
(T 5) $$ (T 4) $$ (T 3) $$ (T 2) $$ (T 1) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (filename):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.blk blk1, blk1left, blk1right)) :: rest671)
) => let val  result = MlyValue.start (fn _ => let val  (blk as blk1)
 = blk1 ()
 in (HashTable.clear typeTable ; DataTypes.PROG(blk))
end)
 in ( LrTable.NT 0, ( result, blk1left, blk1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.cmdseq cmdseq1, _, cmdseq1right)) :: ( _, ( 
MlyValue.decseq decseq1, decseq1left, _)) :: rest671)) => let val  
result = MlyValue.blk (fn _ => let val  (decseq as decseq1) = decseq1
 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 in (DataTypes.BLK(decseq,cmdseq))
end)
 in ( LrTable.NT 1, ( result, decseq1left, cmdseq1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.procdec procdec1, _, procdec1right)) :: ( _,
 ( MlyValue.vardec vardec1, vardec1left, _)) :: rest671)) => let val  
result = MlyValue.decseq (fn _ => let val  (vardec as vardec1) = 
vardec1 ()
 val  (procdec as procdec1) = procdec1 ()
 in (DataTypes.DECSEQ(SOME vardec,SOME procdec))
end)
 in ( LrTable.NT 2, ( result, vardec1left, procdec1right), rest671)

end
|  ( 3, ( ( _, ( MlyValue.vardec vardec1, vardec1left, vardec1right))
 :: rest671)) => let val  result = MlyValue.decseq (fn _ => let val  (
vardec as vardec1) = vardec1 ()
 in (DataTypes.DECSEQ(SOME vardec,NONE))
end)
 in ( LrTable.NT 2, ( result, vardec1left, vardec1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.procdec procdec1, procdec1left, 
procdec1right)) :: rest671)) => let val  result = MlyValue.decseq (fn
 _ => let val  (procdec as procdec1) = procdec1 ()
 in (DataTypes.DECSEQ(NONE,SOME procdec))
end)
 in ( LrTable.NT 2, ( result, procdec1left, procdec1right), rest671)

end
|  ( 5, ( rest671)) => let val  result = MlyValue.decseq (fn _ => (
DataTypes.DECSEQ(NONE,NONE)))
 in ( LrTable.NT 2, ( result, defaultPos, defaultPos), rest671)
end
|  ( 6, ( ( _, ( MlyValue.procdeclist procdeclist1, _, 
procdeclist1right)) :: _ :: ( _, ( MlyValue.procdef procdef1, 
procdef1left, _)) :: rest671)) => let val  result = MlyValue.procdec
 (fn _ => let val  (procdef as procdef1) = procdef1 ()
 val  (procdeclist as procdeclist1) = procdeclist1 ()
 in (DataTypes.PROCDEC( procdef,procdeclist))
end)
 in ( LrTable.NT 9, ( result, procdef1left, procdeclist1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.procdeclist procdeclist1, _, 
procdeclist1right)) :: _ :: ( _, ( MlyValue.procdec procdec1, 
procdec1left, _)) :: rest671)) => let val  result = 
MlyValue.procdeclist (fn _ => let val  (procdec as procdec1) = 
procdec1 ()
 val  (procdeclist as procdeclist1) = procdeclist1 ()
 in (procdec :: procdeclist )
end)
 in ( LrTable.NT 11, ( result, procdec1left, procdeclist1right), 
rest671)
end
|  ( 8, ( rest671)) => let val  result = MlyValue.procdeclist (fn _ =>
 (([])))
 in ( LrTable.NT 11, ( result, defaultPos, defaultPos), rest671)
end
|  ( 9, ( ( _, ( MlyValue.blk blk1, _, blk1right)) :: ( _, ( 
MlyValue.TOKEN_IDENT TOKEN_IDENT1, _, _)) :: ( _, ( _, 
TOKEN_PROCEDURE1left, _)) :: rest671)) => let val  result = 
MlyValue.procdef (fn _ => let val  (TOKEN_IDENT as TOKEN_IDENT1) = 
TOKEN_IDENT1 ()
 val  (blk as blk1) = blk1 ()
 in (DataTypes.PROCDEF (TOKEN_IDENT, blk))
end)
 in ( LrTable.NT 10, ( result, TOKEN_PROCEDURE1left, blk1right), 
rest671)
end
|  ( 10, ( ( _, ( _, _, TOKEN_SEMICOLON1right)) :: ( _, ( 
MlyValue.varlist varlist1, _, _)) :: ( _, ( MlyValue.typedec typedec1,
 typedec1left, _)) :: rest671)) => let val  result = MlyValue.vardec
 (fn _ => let val  (typedec as typedec1) = typedec1 ()
 val  (varlist as varlist1) = varlist1 ()
 in (
( insertInTable( varlist , typedec) ; DataTypes.VARDEC(varlist ,typedec))
)
end)
 in ( LrTable.NT 12, ( result, typedec1left, TOKEN_SEMICOLON1right), 
rest671)
end
|  ( 11, ( ( _, ( MlyValue.TOKEN_IDENT TOKEN_IDENT1, TOKEN_IDENT1left,
 TOKEN_IDENT1right)) :: rest671)) => let val  result = 
MlyValue.varlist (fn _ => let val  (TOKEN_IDENT as TOKEN_IDENT1) = 
TOKEN_IDENT1 ()
 in (([TOKEN_IDENT]))
end)
 in ( LrTable.NT 7, ( result, TOKEN_IDENT1left, TOKEN_IDENT1right), 
rest671)
end
|  ( 12, ( ( _, ( MlyValue.varlist varlist1, _, varlist1right)) :: _
 :: ( _, ( MlyValue.TOKEN_IDENT TOKEN_IDENT1, TOKEN_IDENT1left, _)) ::
 rest671)) => let val  result = MlyValue.varlist (fn _ => let val  (
TOKEN_IDENT as TOKEN_IDENT1) = TOKEN_IDENT1 ()
 val  (varlist as varlist1) = varlist1 ()
 in ((TOKEN_IDENT::varlist))
end)
 in ( LrTable.NT 7, ( result, TOKEN_IDENT1left, varlist1right), 
rest671)
end
|  ( 13, ( ( _, ( _, TOKEN_INTEGER1left, TOKEN_INTEGER1right)) :: 
rest671)) => let val  result = MlyValue.typedec (fn _ => ((Int)))
 in ( LrTable.NT 6, ( result, TOKEN_INTEGER1left, TOKEN_INTEGER1right)
, rest671)
end
|  ( 14, ( ( _, ( _, TOKEN_BOOL1left, TOKEN_BOOL1right)) :: rest671))
 => let val  result = MlyValue.typedec (fn _ => ((Bool)))
 in ( LrTable.NT 6, ( result, TOKEN_BOOL1left, TOKEN_BOOL1right), 
rest671)
end
|  ( 15, ( ( _, ( _, TOKEN_RATIONAL1left, TOKEN_RATIONAL1right)) :: 
rest671)) => let val  result = MlyValue.typedec (fn _ => ((rational)))
 in ( LrTable.NT 6, ( result, TOKEN_RATIONAL1left, 
TOKEN_RATIONAL1right), rest671)
end
|  ( 16, ( ( _, ( _, _, TOKEN_RBRACE1right)) :: ( _, ( 
MlyValue.commands commands1, _, _)) :: ( _, ( _, TOKEN_LBRACE1left, _)
) :: rest671)) => let val  result = MlyValue.cmdseq (fn _ => let val 
 (commands as commands1) = commands1 ()
 in ((commands))
end)
 in ( LrTable.NT 3, ( result, TOKEN_LBRACE1left, TOKEN_RBRACE1right), 
rest671)
end
|  ( 17, ( ( _, ( MlyValue.commands commands1, _, commands1right)) ::
 _ :: ( _, ( MlyValue.command command1, command1left, _)) :: rest671))
 => let val  result = MlyValue.commands (fn _ => let val  (command as 
command1) = command1 ()
 val  (commands as commands1) = commands1 ()
 in ((command::commands))
end)
 in ( LrTable.NT 4, ( result, command1left, commands1right), rest671)

end
|  ( 18, ( rest671)) => let val  result = MlyValue.commands (fn _ => (
([])))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 19, ( ( _, ( MlyValue.TOKEN_IDENT TOKEN_IDENT1, _, 
TOKEN_IDENT1right)) :: ( _, ( _, TOKEN_READ1left, _)) :: rest671)) =>
 let val  result = MlyValue.command (fn _ => let val  (TOKEN_IDENT as 
TOKEN_IDENT1) = TOKEN_IDENT1 ()
 in ((DataTypes.RD(TOKEN_IDENT)))
end)
 in ( LrTable.NT 5, ( result, TOKEN_READ1left, TOKEN_IDENT1right), 
rest671)
end
|  ( 20, ( ( _, ( MlyValue.TOKEN_IDENT TOKEN_IDENT1, _, 
TOKEN_IDENT1right)) :: ( _, ( _, TOKEN_PRINT1left, _)) :: rest671)) =>
 let val  result = MlyValue.command (fn _ => let val  (TOKEN_IDENT as 
TOKEN_IDENT1) = TOKEN_IDENT1 ()
 in ((DataTypes.PR(TOKEN_IDENT)))
end)
 in ( LrTable.NT 5, ( result, TOKEN_PRINT1left, TOKEN_IDENT1right), 
rest671)
end
|  ( 21, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.TOKEN_IDENT TOKEN_IDENT1, TOKEN_IDENT1left, _)) :: rest671))
 => let val  result = MlyValue.command (fn _ => let val  (TOKEN_IDENT
 as TOKEN_IDENT1) = TOKEN_IDENT1 ()
 val  (expr as expr1) = expr1 ()
 in (
( if (checkSameType( getType TOKEN_IDENT, #1 expr)) then () else raise TypeMisMatchException; DataTypes.SET(TOKEN_IDENT,  #2 expr ))
)
end)
 in ( LrTable.NT 5, ( result, TOKEN_IDENT1left, expr1right), rest671)

end
|  ( 22, ( ( _, ( MlyValue.TOKEN_IDENT TOKEN_IDENT1, _, 
TOKEN_IDENT1right)) :: ( _, ( _, TOKEN_CALL1left, _)) :: rest671)) =>
 let val  result = MlyValue.command (fn _ => let val  (TOKEN_IDENT as 
TOKEN_IDENT1) = TOKEN_IDENT1 ()
 in ((DataTypes.CL(TOKEN_IDENT)))
end)
 in ( LrTable.NT 5, ( result, TOKEN_CALL1left, TOKEN_IDENT1right), 
rest671)
end
|  ( 23, ( ( _, ( _, _, TOKEN_ENDIF1right)) :: ( _, ( MlyValue.cmdseq 
cmdseq2, _, _)) :: _ :: ( _, ( MlyValue.cmdseq cmdseq1, _, _)) :: _ ::
 ( _, ( MlyValue.expr expr1, _, _)) :: ( _, ( _, TOKEN_IF1left, _)) ::
 rest671)) => let val  result = MlyValue.command (fn _ => let val  (
expr as expr1) = expr1 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 val  cmdseq2 = cmdseq2 ()
 in (
( if (checkBool (#1 expr)) then () else raise TypeMisMatchException ; DataTypes.ITE( #2 expr, cmdseq, cmdseq))
)
end)
 in ( LrTable.NT 5, ( result, TOKEN_IF1left, TOKEN_ENDIF1right), 
rest671)
end
|  ( 24, ( ( _, ( _, _, TOKEN_OD1right)) :: ( _, ( MlyValue.cmdseq 
cmdseq1, _, _)) :: _ :: ( _, ( MlyValue.expr expr1, _, _)) :: ( _, ( _
, TOKEN_WHILE1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (expr as expr1) = expr1 ()
 val  (cmdseq as cmdseq1) = cmdseq1 ()
 in (
( if (checkBool (#1 expr)) then () else raise TypeMisMatchException ; DataTypes.WH( #2 expr, cmdseq ))
)
end)
 in ( LrTable.NT 5, ( result, TOKEN_WHILE1left, TOKEN_OD1right), 
rest671)
end
|  ( 25, ( ( _, ( MlyValue.TOKEN_IDENT TOKEN_IDENT1, TOKEN_IDENT1left,
 TOKEN_IDENT1right)) :: rest671)) => let val  result = MlyValue.expr
 (fn _ => let val  (TOKEN_IDENT as TOKEN_IDENT1) = TOKEN_IDENT1 ()
 in (( getType TOKEN_IDENT , IDENT(TOKEN_IDENT)))
end)
 in ( LrTable.NT 8, ( result, TOKEN_IDENT1left, TOKEN_IDENT1right), 
rest671)
end
|  ( 26, ( ( _, ( _, _, TOKEN_RPAREN1right)) :: ( _, ( MlyValue.expr 
expr1, _, _)) :: ( _, ( _, TOKEN_LPAREN1left, _)) :: rest671)) => let
 val  result = MlyValue.expr (fn _ => let val  (expr as expr1) = expr1
 ()
 in ((expr))
end)
 in ( LrTable.NT 8, ( result, TOKEN_LPAREN1left, TOKEN_RPAREN1right), 
rest671)
end
|  ( 27, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.ADD(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.SUB(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ; (Int , DataTypes.MUL(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.DIV(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 31, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkInt( #1  expr1) andalso checkInt( #1 expr2) then () else raise TypeMisMatchException ;(Int , DataTypes.MOD(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.TOKEN_NUM TOKEN_NUM1, TOKEN_NUM1left, 
TOKEN_NUM1right)) :: rest671)) => let val  result = MlyValue.expr (fn
 _ => let val  (TOKEN_NUM as TOKEN_NUM1) = TOKEN_NUM1 ()
 in (( Int , DataTypes.NUM(TOKEN_NUM) ))
end)
 in ( LrTable.NT 8, ( result, TOKEN_NUM1left, TOKEN_NUM1right), 
rest671)
end
|  ( 33, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ;(rational , DataTypes.RADD(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ;(rational , DataTypes.RSUB(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ; (rational , DataTypes.RMUL(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkrational( #1  expr1) andalso checkrational( #1 expr2) then () else raise TypeMisMatchException ;(rational , DataTypes.RDIV(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 37, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
TOKEN_UMINUS1left, _)) :: rest671)) => let val  result = MlyValue.expr
 (fn _ => let val  (expr as expr1) = expr1 ()
 in (
(if checkrational(#1 expr) then () else raise TypeMisMatchException ;(rational , DataTypes.RUMINUS( #2 expr)))
)
end)
 in ( LrTable.NT 8, ( result, TOKEN_UMINUS1left, expr1right), rest671)

end
|  ( 38, ( ( _, ( MlyValue.TOKEN_R TOKEN_R1, TOKEN_R1left, 
TOKEN_R1right)) :: rest671)) => let val  result = MlyValue.expr (fn _
 => let val  (TOKEN_R as TOKEN_R1) = TOKEN_R1 ()
 in (( rational, DataTypes.R(TOKEN_R) ))
end)
 in ( LrTable.NT 8, ( result, TOKEN_R1left, TOKEN_R1right), rest671)

end
|  ( 39, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.LTE( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 40, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.LT( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.GTE( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 42, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.GT( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.EQ( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
( if checkSameType( #1 expr1, #1 expr2) then () else raise TypeMisMatchException ; (Bool, DataTypes.NE( #2 expr1, #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 45, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if checkBool( #1  expr1) andalso checkBool( #1 expr2) then () else raise TypeMisMatchException ;(Bool , DataTypes.AND(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 46, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
(if checkBool( #1  expr1) andalso checkBool( #1 expr2) then () else raise TypeMisMatchException ;(Bool , DataTypes.OR(#2 expr1 , #2 expr2)))
)
end)
 in ( LrTable.NT 8, ( result, expr1left, expr2right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, 
TOKEN_NOT1left, _)) :: rest671)) => let val  result = MlyValue.expr
 (fn _ => let val  (expr as expr1) = expr1 ()
 in (
(if checkBool( #1  expr) then () else raise TypeMisMatchException ;(Bool , DataTypes.NOT(#2 expr)))
)
end)
 in ( LrTable.NT 8, ( result, TOKEN_NOT1left, expr1right), rest671)

end
|  ( 48, ( ( _, ( _, TOKEN_TT1left, TOKEN_TT1right)) :: rest671)) =>
 let val  result = MlyValue.expr (fn _ => ((Bool,TRUE)))
 in ( LrTable.NT 8, ( result, TOKEN_TT1left, TOKEN_TT1right), rest671)

end
|  ( 49, ( ( _, ( _, TOKEN_FF1left, TOKEN_FF1right)) :: rest671)) =>
 let val  result = MlyValue.expr (fn _ => ((Bool,FALSE)))
 in ( LrTable.NT 8, ( result, TOKEN_FF1left, TOKEN_FF1right), rest671)

end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.start x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Ration_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun TOKEN_PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_UMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_MULTIPLY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_DIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_MOD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_EQUAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_NE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_GTE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_LTE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_NOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_INTEGER (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_BOOL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_READ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_WRITE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_ENDIF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_OD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_TT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_FF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_IDENT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.TOKEN_IDENT (fn () => i),p1,p2))
fun TOKEN_NUM (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.TOKEN_NUM (fn () => i),p1,p2))
fun TOKEN_EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_SHOW_RAT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_MAKE_RAT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_LCOMMENT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RCOMMENT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_SHOW_DECIMAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43
,(ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_TO_DECIMAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_FI (p1,p2) = Token.TOKEN (ParserData.LrTable.T 45,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RPLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 46,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 47,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RMULTIPLY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 48,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RDIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 49,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_INVERSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 50,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RATIONAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 51,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_CALL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 52,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_PROCEDURE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 53,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_PRINT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 54,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_RAT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 55,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_BLOCK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 56,(
ParserData.MlyValue.VOID,p1,p2))
fun TOKEN_R (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 57,(
ParserData.MlyValue.TOKEN_R (fn () => i),p1,p2))
end
end
