// breadth = 2
//@ proof
module LEMMA-ADD-ONE-IF-NOT-NEGATIVE
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports INSTRUMENTATION-CONCRETIZE
//@ trusted
// require "protocol-correctness/lib/functions/add-one-if-not-negative.k"
// 
// module TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE
//@ end

  imports ADD-ONE-IF-NOT-NEGATIVE-SYNTAX
  imports BOOL

  lemma
      concretizeValue(X >=Int 0) => .K
    proves
      addOneIfNotNegative(X:Int) >=Int 0 => X >=Int 0
    requires
      true
    [simplification]
    endlemma

  lemma
      concretizeValue(X >=Int 0) => .K
    proves
      addOneIfNotNegative(X:Int) >Int 0 => X >=Int 0
    requires
      true
    [simplification]
    endlemma

  lemma
      concretizeValue(X >=Int 0) => .K
    proves
      addOneIfNotNegative(X:Int) <Int 0 => X <Int 0
    requires
      true
    [simplification]
    endlemma

endmodule
