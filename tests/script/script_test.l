#import system.
#import system'dynamic.
#import extensions'scripting.

#symbol program2 =
[
    #var n := script_test'mytest'States state0.
].

#symbol tester =
{
    newLeaf : n
        = n.
}.

#symbol program =
[
    #var factory := scriptEngine 
        load &path:"~\scripts\assembly.es" 
        load &path:"~\scripts\eson.es" 
        eval &path:"test.es".   
        
    #var obj := factory eval:(Library new) first eval.
    
    #var n := obj state0.
    #var m := script_test'mytest'States state0.
  
    #var nmix := Group(tester, n).
    #var mmix := Group(tester, m).
        
    #var nn := nmix digit:3.
    #var mm := mmix digit:3.
].