// breadth = 4
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
      andBool isKResult(Value)
    ensures true
      andBool Value ==K [?_CSV:ExpressionCSV]
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
      andBool isKResult(Value)
    ensures true
      andBool Value ==K u(?_V)
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
      andBool isKResult(Value)
    ensures true
      andBool Value ==K address(?_V)
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
      andBool isKResult(Value)
      andBool Value ==K BoardMember
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
      andBool isKResult(Value)
      andBool Value ==K Proposer
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
      andBool isKResult(Value)
      andBool Value =/=K BoardMember
      andBool Value =/=K Proposer
    ensures true
      andBool Value ==K None
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
