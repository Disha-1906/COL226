Grammar for Rational Numbers : 
    NumSeq := [Sign]{Digit} | [Sign]{Digit} DecPt {Digit} LParen Digit{Digit} RParen | LParen [Sign] Digit{Digit} Comma {Digit}NZDigit{Digit} RParen
    NZDigit := "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
    Digit := "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|"0"
    Sign := "+"|"~"
    Comma := ","
    DecPt := "."
    LParen := "("
    RParen := ")"

Grammar for Rational Expressions : 
    Expression := Expression AdSb Term | Term
    Term := Term MultOp Factor | Factor
    Factor := Factor DivOp NumSeq | NumSeq
    NumSeq := [Sign]{Digit} | [Sign]{Digit} DecPt {Digit} LParen Digit{Digit} RParen | LParen [Sign] Digit{Digit} Comma {Digit}NZDigit{Digit} RParen
    NZDigit := "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
    Digit := "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|"0"
    Sign := "+"|"~"
    Comma := ","
    DecPt := "."
    LParen := "("
    RParen := ")"
    AdSb := AddOp | SubOp
    AddOp := "+"
    SubOp := "-"
    MultOp := "*" 
    DivOp := "/" 

For signature BIGINT:
Design decisions:

The BIGINT signature defines a module that provides operations for arbitrary precision integer arithmetic.
The bigint type is represented as a string.
The bigint_error exception can be used to signal errors that occur during operations on bigint values.
The sign function returns the sign of a bigint value as an integer (-1 for negative, 0 for zero, and 1 for positive).
The sameSign function returns true if two bigint values have the same sign.
The negate function returns the negation of a bigint value.
The comparison functions (greater_than, greater_eq, equal_bigint, less_eq, and less_than) compare two bigint values and return true if the comparison holds.
The arithmetic functions (add_bigint, sub_bigint, multiply_bigint, division, and remainder) perform the corresponding arithmetic operation on two bigint values and return the result as a new bigint value.

Pragmatic decisions:

The bigint type is represented as a string because it allows for arbitrary precision and avoids overflow issues.
The sign function returns an integer rather than a string to make it easier to use the result in further calculations.
The comparison functions use descriptive names to make their behavior clear and consistent with other languages and libraries.
The arithmetic functions use descriptive names and are implemented as pure functions that take two arguments and return a new value to avoid side effects and simplify their use.
All the defined functions also work correctly on input containing leading zeroes.
All the functions use digit by digit operation processing thereby optimizing the operations for large integers.


For RAT functor:
Design decisions:

The RAT functor defines a module that provides operations for rational numbers, represented as pairs of bigint values.
The BIGINT module is required as a parameter to the RAT functor, which allows the implementation of rational numbers to use the bigint operations from the BIGINT module.
The rational type is defined as a pair of bigint values, representing the numerator and denominator of the rational number.
The rat_error exception can be used to signal errors that occur during operations on rational numbers.

Pragmatic decisions:

The RAT functor allows for modular design and reuse of the BIGINT module, which may already have been implemented and tested separately.
The rational type is represented as a pair of bigint values to enable arbitrary precision arithmetic for the numerator and denominator, which is necessary for accurate results in many calculations.
The make_rat function returns an optional rational value to allow for the possibility of a denominator of zero or other errors that may occur during construction of a rational number.
The rat and reci functions return optional rational values to handle errors that may occur during their computation, such as division by zero.
The showRat and showDecimal functions convert rational values to strings for display or serialization purposes.
The fromDecimal and toDecimal functions allow for conversion between rational and decimal representations.
The arithmetic functions (neg, inverse, equal, less, add, subtract, multiply, and divide) operate on rational values and return new rational values, using the bigint operations provided by the BIGINT module where necessary.
All the defined functions also work correctly on input containing leading zeroes



    

