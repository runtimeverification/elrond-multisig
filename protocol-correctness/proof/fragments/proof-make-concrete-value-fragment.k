// breadth = 1
// Fails because of https://github.com/kframework/kore/issues/2828
//@ proof
module PROOF-MAKE-CONCRETE-VALUE-FRAGMENT
//@ trusted
// module TRUSTED-MAKE-CONCRETE-VALUE-FRAGMENT
//@ end
  imports INVARIANT

  claim endSplitMap
        ~> cast(Value:KItem, rExpressionList)
        ~> removeValue
        ~> concretizeValue(Value)
      =>
        .K
    requires true
      andBool isExpressionList(Value)
    ensures true
      andBool Value ==K [?CSV:ExpressionCSV]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim endSplitMap
        ~> cast(Value:KItem, rUsize)
        ~> removeValue
        ~> concretizeValue(Value)
      =>
        .K
    requires true
      andBool isUsize(Value)
    ensures true
      andBool Value ==K u(?V)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim endSplitMap
        ~> cast(Value:KItem, rAddress)
        ~> removeValue
        ~> concretizeValue(Value)
      =>
        .K
    requires true
      andBool isAddress(Value)
    ensures true
      andBool Value ==K address(?V)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim endSplitMap
        ~> cast(Value:KItem, rUserRole)
        ~> removeValue
        ~> concretizeValue(Value)
      =>
        .K
    requires true
      andBool isUserRole(Value)
    ensures true
      andBool {Value #Equals BoardMember} #Or {Value #Equals Proposer} #Or {Value #Equals None}
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
