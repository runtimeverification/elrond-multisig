// breadth = 1
// Not working because of https://github.com/kframework/kore/issues/2740
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-swap-remove.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
//@ end

  imports LIST-CONTAINS-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      lemmaIterateListContains2([Es], I) => .K
    proves
      #listContains([E1:Expression, #listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) => false
    requires
      notBool #listContains([E1, Es], E)
    [simplification]
    endlemma

endmodule
