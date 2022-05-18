// breadth = 2
//@ proof
module PROOF-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET
//@ trusted
// 
// module TRUSTED-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET
//@ end

  imports NAMED-LEMMA-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET-SYNTAX
  imports K-EQUAL-SYNTAX
  imports MAP
  imports INT

  claim 
    lemmaInKeysSquareBracketSquareBracket(M:Map, E:KItem, E1:KItem) => .K
  ensures
    E in_keys(M:Map[E <- 0][E1 <- 0])
  //@ proof
  //@ trusted
  // [trusted]
  //@ end

endmodule
/*
E in M[E <- 0][E1 <- 0] => true
  requires
    E =/=K EDelete

case E1 == E of
  True ->
    E in M[E <- 0][E <- 0] => true
      requires
        E =/=K EDelete
    ok.
  False ->
    E in M[E <- 0][E1 <- 0] => true
      requires
        E =/=K EDelete
        andBool E =/= E1
    E in M[E <- 0] => true
      requires
        E =/=K EDelete
        andBool E =/= E1
    ok.
*/
