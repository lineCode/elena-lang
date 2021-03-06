import system'routines.
import extensions.

// --- program ---

program =
[
    var Doors := Array new:100; set every: (&int:n) [ ^false ].
    
    0 till:100 doEach: (:i)
    [
        i till:100 by:(i + 1) doEach: (:j)
        [  
            Doors@j := Doors@j not
        ]
    ].
            
    0 till:100 doEach: (:i)
    [
        console printLine:"Door #":(i + 1):" :":(Doors@i iif:"Open":"Closed")
    ].
    
    console readChar.
].