// breadth = 2
//@ proof

module PROOF-PUSH-LIST-NOT-EMPTY
//@ trusted
// module TRUSTED-PUSH-LIST-NOT-EMPTY
//@ end
  imports K-EQUAL-SYNTAX
  imports PUSHLIST-INSTRUMENTATION-SYNTAX
  imports PSEUDOCODE-FUNCTIONS-SYNTAX
  imports PUSH-LIST-SYNTAX

  claim lemmaPushListNotEmpty(L:ExpressionCSV, E:Expression) => .K
    requires true
    ensures notBool .:ExpressionCSV ==K #pushList(L, E)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
