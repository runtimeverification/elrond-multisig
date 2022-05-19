// breadth = 3
//@ proof
module LEMMA-MAP-KEYS-ARE-KRESULT-USER-ID-TO-ROLE
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/proof/invariant.k"
// require "protocol-correctness/lib/functions/map-keys-are-kresult.k"
// //
// module TRUSTED-LEMMA-MAP-KEYS-ARE-KRESULT-USER-ID-TO-ROLE
//@ end

  imports INVARIANT-HELPERS
  imports MAP-KEYS-ARE-KRESULT-SYNTAX

  lemma
      induction(
        case "m" of
          | . -> .Induction .
          | "m1"["k" <- "v"] -> reinduction("m1") .
        esac,
        ("m", M:Map)
      )
      => .K
    proves
      mapKeysAreKResult(M:Map) => true
    requires
      true
      andBool userIdToRoleInvariant(M)
    [simplification]
    endlemma

endmodule

