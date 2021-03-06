import system'dynamic.
import system'routines.
import extensions.
import extensions'routines.
import extensions'text.

extension bottleOp
{
    bottleDescription
        = self literal + (self != 1) iif:" bottles":" bottle".
        
    bottleEnumerator = Variable new:self; eval with:(:target)
    [
        ^ Enumerator::
        {
            next = target > 0.
            
            get = StringWriter new;
                    printLine:(target bottleDescription):" of beer on the wall";
                    printLine:(target bottleDescription):" of beer";
                    printLine:"Take one down, pass it around";
                    printLine:((target reduce:1) bottleDescription):" of beer on the wall".
        }
    ].
}

program =
[
    var bottles := 99.
    
    bottles bottleEnumerator; run each:printingLn.
].