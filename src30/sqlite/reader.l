#define system.
#define system'routines.

#class(sealed)DBReader
{
    #field(type:sqlite_cmd)theCommand.
    #field(type:handle)theCommandHandle.
    #field(type:array) theFieldNames.
    
    #constructor new &sqlite_cmd:aCommand
    [
        theCommand := aCommand.
        
        theCommandHandle := aCommand handle.
    ]
    
    #method sqlite_reader = $self.
    
    #method readNext &vint:aResult
    [
        #var(type:int) aRetVal := system'external'sqlite3 sqlite3_step &handle:theCommandHandle.
        
        aResult << aRetVal.
    ]
    
    #method(type:bool)next
    [
        #var(type:int)aResult.
        $self readNext &vint:aResult.
        
        ^ aResult != SQLITE_ROW.
    ]
    
    #method getAt : aSelector
        = aSelector cast:%eval &with:$self &to:
            {
                eval : aReader &int : anInt = aReader getAt &index:anInt.
                
                eval : aReader &literal : aFieldName = aReader getAt &literal:aFieldName.
                
                eval : aReader &wide : aFieldName = aReader getAt &literal:(aFieldName literal).
            }.
    
    #method getAt &index:anIndex
    [
        #var(type:int) columnType := system'external'sqlite3 sqlite3_column_type &handle:theCommandHandle &int:anIndex.
        
        (columnType == SQLITE_INTEGER)?
        [
            #var(type:int) val := system'external'sqlite3 sqlite3_column_int &handle:theCommandHandle &int:anIndex.
            
            ^ IntNumber new &int:val.
        ].
        
        (columnType == SQLITE_TEXT)?
        [
            #var(type:dirty_ptr)aColumnTextPtr := system'external'sqlite3 sqlite3_column_text &handle:theCommandHandle &int:anIndex.

            ^ aColumnTextPtr literal.
        ].
        
//        (columnType == SQLITE_FLOAT)?
//        [
//            #var(type:real) val := system'external'sqlite3 sqlite3_column_double &handle:theCommandHandle &int:anIndex.
//            
//            row@counter := val.
//        ].

        (columnType == SQLITE_NULL)?
        [
            ^ $nil.
        ].

        #throw DBException new &message:"Unsupported type".
    ]
    
    #method getAt &literal:aFieldName
    [
        ($nil == theFieldNames)
            ? [ theFieldNames := theCommand sql_field_names. ].
            
        ^ $self getAt &index:(theFieldNames indexOf:aFieldName int).
    ]
    
    #method sqlite_row
    [
        #var(type:int)aCount.
        theCommand readFieldCount &vint:aCount.
        
        #var(type:array) aRow := Array new &length:aCount.
        #var(type:int)i := 0.
        #loop (i < aCount)?
        [
            aRow setAt &index:i &object:($self getAt &index:i).
            
            i := i + 1.
        ].
        
        ^ aRow.
    ]
    
    #method enumerator = Enumerator
    {
        #method get = self sqlite_row.
    
        #method(type:bool) next => self.
    }.
}