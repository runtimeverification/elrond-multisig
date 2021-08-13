// timeout = moderate
// breadth = 4
//@ proof
module PROOF-LISTLEN
//@ trusted
// module TRUSTED-LISTLEN
//@ end
  imports FUNCTION-CALL-SYNTAX
  imports PSEUDOCODE-FUNCTIONS-SYNTAX

  //@ proof
  claim call(listLen([.])) => u(0)

  claim call(listLen([E:Expression , Es:ExpressionCSV])) => u(1 +Int pListLen([Es]))
    requires isKResult(E) andBool isKResult(Es)
  //@ trusted
  //@ end

  claim call(listLen(L:ExpressionList)) => u(pListLen(L))
    requires isKResult(L)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
