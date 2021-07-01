// breadth = 3
//@ proof
module LEMMA-POUND-REMOVE-LAST-KRESULT-EXPRESSION
  imports LIST-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-POUND-REMOVE-LAST-KRESULT-EXPRESSION
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      lemmaSplitListExpression2(E, [Es]) => .K
    proves
      isKResultExpressionCSV(#removeLast(E, Es)) => true
    requires
      isKResult(E) andBool isKResult(Es)
    [simplification]
    endlemma

endmodule
