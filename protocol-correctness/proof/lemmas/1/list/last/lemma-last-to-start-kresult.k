// breadth = 3
//@ proof
module LEMMA-LAST-TO-START-KRESULT
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports INSTRUMENTATION-CONCRETIZE

//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/plistlen-functions.k"
// require "protocol-correctness/lib/functions/last-to-start.k"
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
