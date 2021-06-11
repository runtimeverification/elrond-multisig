// breadth = 2
//@ proof

module PROOF-PUSH-LIST-NOT-EMPTY
//@ trusted
// module TRUSTED-PUSH-LIST-NOT-EMPTY
//@ end
  imports PUSHLIST-EXECUTE-SYNTAX
  imports PSEUDOCODE-FUNCTIONS-SYNTAX

  claim lemmaPushListNotEmpty(L:ExpressionCSV, E:Expression) => .K
    requires true
    ensures notBool .:ExpressionCSV ==K #pushList(L, E)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
