// breadth = 3
//@ proof
module PROOF-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING
//@ trusted
// module TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING
// require "protocol-correctness/lib/functions/map-keys-are-below-limit.k"
// require "protocol-correctness/lib/functions/map-keys-are-of-type.k"
//@ end

  imports FORMULA-EXPANSION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports MAP
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-KEYS-ARE-OF-TYPE-SYNTAX
  imports NAMED-LEMMAS-SYNTAX

  claim lemmaMapKeysAreBelowLimitIgnoresPropertyHandling(
            Limit:Int, M:Map, H1:PropertyHandling, H2:PropertyHandling)
        => .K
    requires mapKeysAreOfType(M, rUsize)
    ensures mapKeysAreBelowLimitSafe(Limit, M, H1) ==K mapKeysAreBelowLimitSafe(Limit, M, H2)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
