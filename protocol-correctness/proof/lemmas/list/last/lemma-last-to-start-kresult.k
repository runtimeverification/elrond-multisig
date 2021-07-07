// breadth = 3
//@ proof
module LEMMA-LAST-TO-START-KRESULT
  imports LEMMAS-EXECUTE-SYNTAX
  imports INSTRUMENTATION-CONCRETIZE

//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/last-to-start.k"
// 
// module TRUSTED-LEMMA-LAST-TO-START-KRESULT
//@ end

  imports LAST-FUNCTIONS-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports LAST-TO-START-SYNTAX

  lemma
      lemmaSplitList2([Es]) => .K
    proves
      isKResultExpressionCSV(lastToStart(Es)) => isKResult(Es)
    requires
      true
    [simplification]
    endlemma

endmodule
