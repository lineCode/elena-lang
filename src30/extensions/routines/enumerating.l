#define system.
#define system'io.
#define system'text.
#define extensions'text.

#subject(class:system'BaseFunction1) eachWord.
#subject(class:system'BaseFunction1) eachLine.

// --- ReaderEnumerator ---

#class ReaderEnumerator :: Enumerator
{
    #field(type:textreader) theReader.
    #field theLine.

    #constructor new
    [
    ]

    #constructor new &stream:aStream &encoder:anEncoder
        <= (%new)
    [
        theReader := StreamReader new &stream:aStream &encoder:anEncoder.
    ]        
                        
    #constructor new &path:aPath
        <= (%new)
    [
        theReader := StreamReader new &path:aPath.
    ]
    
    #constructor new &path:aPath &encoder:anEncoder
        <= (%new)
    [
        theReader := StreamReader new &path:aPath &encoder:anEncoder.
    ]
    
    #method reset 
    [
        theReader := StreamReader new &stream:(theReader stream clone) &encoder:(theReader encoder).
    ]
    
    #method next
    [
        (theReader available)
            ? [
                theLine := theReader read &literal.
                
                ^ true.            
            ].
        
        theReader close.
        
        ^ false.
    ]
    
    #method get = theLine.
}

// --- fileExOp ---

#class(extension:file)fileExOp
{
    #method run &eachLine:anAction
        = anAction run &enumerator:(ReaderEnumerator new &path:self).
}

// --- stringExOp ---

#class(extension)stringExOp
{
    #method run &eachWord:aFunction
        = aFunction run &enumerator:(WordEnumerator new &literal:(self literal)).
}

// --- printingLn ---

#symbol printingLn = aLine [ 'program'output writeLine:aLine ].