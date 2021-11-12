// breadth = 2
//@ proof
module LEMMA-SQUARE-BRACKET-ORDEFAULT-NOT-IN-KEYS
  imports INDUCTION-SYNTAX
//@ trusted
// 
// module TRUSTED-LEMMA-SQUARE-BRACKET-ORDEFAULT-NOT-IN-KEYS
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports MAP

  lemma
      induction(
          .Induction,
          ("m", M:Map) <> ("k1", K1:KItem) <> ("v", V:KItem) <> ("k2", K2:KItem) <> ("D", D:KItem)
        )
      => .K
    proves
      (M:Map K1:KItem |-> V:KItem)[K2] orDefault D => M[K2] orDefault D
    requires
      K1 =/=K K2
    [simplification]
    endlemma

endmodule
