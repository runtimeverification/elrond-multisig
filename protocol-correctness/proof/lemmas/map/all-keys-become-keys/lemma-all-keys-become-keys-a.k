// breadth = 2
//@ proof
module LEMMA-ALL-KEYS-BECOME-KEYS-A
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/all-keys-become-keys.k"
// 
// module TRUSTED-LEMMA-ALL-KEYS-BECOME-KEYS-A
//   imports BOOL
//@ end

  imports ALL-KEYS-BECOME-KEYS-SYNTAX

  lemma
      lemmaIterateMap(M:Map, args3(K, V, N)) => .K
    proves
      allKeysBecomeKeys(M, K:KItem |-> V:KItem N:Map) => true
    requires
      allKeysBecomeKeys(M, N) andBool notBool K in_keys(N)
    [simplification]
    endlemma

endmodule