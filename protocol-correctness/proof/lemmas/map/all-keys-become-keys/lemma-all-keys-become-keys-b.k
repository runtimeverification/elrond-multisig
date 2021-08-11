// breadth = 3
//@ proof
module LEMMA-ALL-KEYS-BECOME-KEYS-B
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/all-keys-become-keys.k"
// 
// module TRUSTED-LEMMA-ALL-KEYS-BECOME-KEYS-B
//   imports BOOL
//@ end

  imports ALL-KEYS-BECOME-KEYS-SYNTAX

  lemma
      lemmaIterateMapSplitInKeys(M:Map, args2(K, V), N) => .K
    proves
      allKeysBecomeKeys(M, K:KItem |-> V:KItem N:Map) => allKeysBecomeKeys(M, N)
    requires
      notBool K in_keys(M) andBool notBool K in_keys(N)
    [simplification]
    endlemma

endmodule