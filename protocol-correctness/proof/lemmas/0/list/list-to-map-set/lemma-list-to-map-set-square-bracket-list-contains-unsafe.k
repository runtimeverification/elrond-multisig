// breadth = 1
//@ proof
require "../../../0/list/contains/trusted-list-contains-unsafe-to-in-keys.k"  //@ Bazel remove

module LEMMA-LIST-TO-MAP-SET-SQUARE-BRACKET-LIST-CONTAINS-UNSAFE
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS-SYNTAX
  imports RUNNING-SYNTAX
  imports TRUSTED-LIST-CONTAINS-UNSAFE-TO-IN-KEYS
//@ trusted
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// 
// module TRUSTED-LEMMA-LIST-TO-MAP-SET-SQUARE-BRACKET-LIST-CONTAINS-UNSAFE
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX

  lemma
      (nop ~> lemmaListContainsUnsafeToInKeys(E:Expression, Es:ExpressionCSV))
      => .K
    proves
      listToMapSet([Es:ExpressionCSV])[E:Expression <- 0]
      => listToMapSet([Es]) E |-> 0
    requires
      notBool #listContainsUnsafe([Es], E)
    [simplification]
    endlemma

endmodule
/*
  listToMapSet([es])[e <- 0] => listToMapSet([es]) e |-> 0
      requires notBool #listContainsUnsafe([es], e)
    
  *** notBool e in_keys(listToMapSet([es])) requires notBool #listContainsUnsafe([es], e)

  listToMapSet([es])[e <- 0] => listToMapSet([es]) e |-> 0
      requires true
        andBool notBool #listContainsUnsafe([es], e)
        andBool notBool e in_keys(listToMapSet([es]))

  listToMapSet([es]) e |-> 0 => listToMapSet([es]) e |-> 0
      requires true
        andBool notBool #listContainsUnsafe([es], e)
        andBool notBool e in_keys(listToMapSet([es]))

  ok.
 */