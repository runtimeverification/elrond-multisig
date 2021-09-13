// breadth = 1
//@ proof
module PROOF-IMPLIES
//@ trusted
// module TRUSTED-IMPLIES
//@ end

  imports BOOL
  imports K-EQUAL
  imports MAP
  imports NAMED-LEMMAS-SYNTAX

  claim lemmaImplies(A:Bool, B:Bool) => .K
    requires A andBool B
    ensures A impliesBool B
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim lemmaImplies(A:Bool, B:Bool) => .K
    requires notBool A
    ensures A impliesBool B
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
