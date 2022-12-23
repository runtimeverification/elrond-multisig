// breadth = 1
//@ proof
module PROOF-NO-MAP-KEY-IN-LIST-LIST-TO-MAP-SET
//@ trusted
// module TRUSTED-NO-MAP-KEY-IN-LIST-LIST-TO-MAP-SET
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMAS-SYNTAX
  imports NO-MAP-KEY-IN-LIST-SYNTAX

  claim lemmaNoMapKeyInListListToMapSet(
            ToRemove:Usize, M:Map, Old:ExpressionList, New:ExpressionList)
        => .K
    requires true
        andBool listToMapSet(New)[ToRemove <- undef]
            ==K listToMapSet(Old)[ToRemove <- undef]
        andBool noMapKeyInList(M[ToRemove <- undef], Old)
    ensures noMapKeyInList(M[ToRemove <- undef], New)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
