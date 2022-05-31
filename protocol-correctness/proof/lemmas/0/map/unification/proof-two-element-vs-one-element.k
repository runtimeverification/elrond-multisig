// breadth = 1
//@ proof
module PROOF-TWO-ELEMENT-VS-ONE-ELEMENT
//@ trusted
// module TRUSTED-TWO-ELEMENT-VS-ONE-ELEMENT
//@ end

  imports BOOL
  imports EQUALITY-WITHOUT-SUBSTITUTION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports MAP
  imports NAMED-LEMMA-MAP-TWO-ELEMENT-VS-ONE-ELEMENT-SYNTAX

  claim lemmaMapTwoElementVsOneElement(
            K1:KItem, V1:KItem, K2:KItem, V2:KItem, M:Map)
        => .K
    requires true
    ensures notBool (K1 |-> V1 K2 |-> V2 M) ==K (K1 |-> V1)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
