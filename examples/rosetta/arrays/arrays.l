/// basic array syntax

#import system'collections.
#import extensions.

program =
[
    var aStaticArray := (1, 2, 3).
    
    var anArray := system'Array new &length:3.
    anArray@0 := 1.
    anArray@1 := 2.
    anArray@2 := 3.
    
    int(3) aStackAllocatedArray := 0.
    aStackAllocatedArray@0 := 1.
    aStackAllocatedArray@1 := 2.
    aStackAllocatedArray@2 := 3.            
    
    var aDynamicArray := ArrayList new.
    aDynamicArray += 1.
    aDynamicArray += 2.
    aDynamicArray += 4.
 
    aDynamicArray@2 := 3.    
    
    system'console writeLine:(anArray@0).
    system'console writeLine:(aStackAllocatedArray@1).
    system'console writeLine:(aDynamicArray@2).
].