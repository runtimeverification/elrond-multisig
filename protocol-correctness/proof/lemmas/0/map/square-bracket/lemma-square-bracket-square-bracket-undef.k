// breadth = 2
//@ proof
module LEMMA-SQUARE-BRACKET-SQUARE-BRACKET-UNDEF
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// 
// module TRUSTED-LEMMA-SQUARE-BRACKET-SQUARE-BRACKET-UNDEF
//@ end

  imports BOOL
  imports MAP

  lemma
      induction(
          case "m" key "k" of
            | . -> .Induction .
            | "m1"["k1" <- "v1"] -> .Induction .
          esac,
          ("m", M:Map) <> ("k", K:KItem) <> ("v", V:KItem)
        )
      => .K
    proves
      M:Map[K:KItem <- V:KItem][K <- undef] => M[K <- undef]
    requires
      true
    [simplification]
    endlemma

endmodule
