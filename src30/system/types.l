// === basic stack allocated types ===

#type(size:4,wrapper:system'IntNumber)  int.
#type(size:8,wrapper:system'LongNumber) long.
#type(size:8,wrapper:system'RealNumber) real.
#type(size:2,wrapper:system'ShortNumber)short.

#type(itemsize:1,wrapper:system'ByteArray) bytearray.
#type(itemsize:2,wrapper:system'ShortArray)shortarray.

// === basic dynamic types ===
#type(wrapper:system'LiteralValue)literal.
#type params.

// === int synonyms ===
#type(synonym:int) length.
#type(synonym:int) index.

// === other types ===
#type bool.
#type action.