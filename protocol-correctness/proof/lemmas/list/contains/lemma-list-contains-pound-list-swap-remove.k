// breadth = 1
// Not working because of https://github.com/kframework/kore/issues/2740
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
  imports LEMMAS-EXECUTE-SYNTAX

//@ trusted
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-swap-remove.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
//@ end

  imports LIST-CONTAINS-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

//@ proof
  // claim lemmaIterateList([Es], args1(I)) => .K
  //   requires I >Int 0 andBool notBool #listContains([Es], E)
  //   ensures #listContains([#listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) ==K false

  // claim lemmaIterateList([Es], args1(I)) => .K
  //   requires I ==Int 0 andBool notBool #listContains([Es], E)
  //   ensures #listContains([#listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) ==K false

  // claim lemmaIterateList([Es], args1(I)) => .K
  //   requires I <Int 0 andBool notBool #listContains([Es], E)
  //   ensures #listContains([#listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) ==K false
//@ trusted
//@ end

  lemma
      lemmaIterateListContains2([Es], I) => .K
    proves
      #listContains([#listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) => false
    requires
      notBool #listContains([Es], E)
    [simplification]
    endlemma

endmodule
