#import system'culture.

program =
[
    var s1 := "alphaBETA".
    
    // Alternative 1
    console writeLine:(s1::caseLiteralOp lowerCase).
    console writeLine:(s1::caseLiteralOp upperCase).
    
    // Alternative 2
    console writeLine:(s1 toLower &locale:currentLocale).
    console writeLine:(s1 toUpper &locale:currentLocale).
    console readChar.
].