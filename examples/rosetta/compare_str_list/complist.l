// Given a list of arbitrarily many strings, show how to:
//   - test if they are all lexically equal
//   - test if every string is lexically less than the one after it (i.e. whether the list is in strict ascending order) 

#import system.
#import system'collections.
#import system'routines.
#import extensions.

#class(extension)helper
{
    #method is &equal
        = $nil == self seek &each:m [ m equal:(self firstMember) not ].
        
    #method is &ascending
    [
        #var former := self enumerator.
        #var later := self enumerator.
        
        later next.
        
        ^ $nil == former zip:later &into:(:prev:next)[ next <= prev ] seek &each: b=[ b ].
    ]
}

#symbol program =
[
    (("AA","BB","CC"),("AA","AA","AA"),("AA","CC","BB"),("AA","ACB","BB","CC"),List new += "single_element")
        run &each: list
        [
            console writeLine:list:" all equal - ":(list is &equal).
            console writeLine:list:" ascending - ":(list is &ascending).
        ].
        
    console readChar.            
].