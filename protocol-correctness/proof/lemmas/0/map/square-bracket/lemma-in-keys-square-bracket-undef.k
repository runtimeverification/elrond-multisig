// breadth = 2
//@ proof
module LEMMA-IN-KEYS-SQUARE-BRACKET-UNDEF
  imports INDUCTION-SYNTAX
//@ trusted
// 
// module TRUSTED-LEMMA-IN-KEYS-SQUARE-BRACKET-UNDEF
//@ end

  imports K-EQUAL-SYNTAX
  imports MAP

  lemma
      induction(
          case "m" key "kdelete" of
            | . -> .Induction .
            | "m1"["k1" <- "v1"] -> .Induction .
          esac,
          ("m", M:Map) <> ("k", K:KItem) <> ("kdelete", KDelete:KItem)
        )
      => .K
    proves
      (K in_keys(M:Map[KDelete <- undef])) => (K in_keys(M))
    requires
      K =/=K KDelete
    [simplification]
    endlemma

endmodule
/*
E in M[EDelete <- undef] => E in M
  requires E =/= EDelete

case EDelete in M of
  . ->
    E in M[EDelete <- undef] => E in M
      requires E =/= EDelete
        andBool notBool EDelete in M
    E in M => E in M
      requires E =/= EDelete
        andBool notBool EDelete in M
    ok.
  M1 EDelete |-> V ->
    E in (M1 EDelete |-> V)[EDelete <- undef] => E in (M1 EDelete |-> V)
      requires E =/= EDelete
    E in M1=> E in M1
      requires E =/= EDelete
    ok.
*/