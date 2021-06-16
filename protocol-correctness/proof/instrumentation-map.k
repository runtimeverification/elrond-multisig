require "protocol-correctness/proof/instrumentation-proof.k"
require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-MAP
  imports MAP

  imports INSTRUMENTATION-PROOF
  imports PSEUDOCODE

  rule  nullableMapLookup(_:KItem, M:Map, _:ReflectionType)
        ~> (.K => lazyConcretizeKeys(M))
        ~> K:KItem
    requires notBool isLazyConcretize(K)
     [priority(20)]
  rule (E:Expression => .K) ~> lazyConcretizeKeys(_) ~> (.K => E)
    [priority(20)]

  rule  nullableMapSet(_:KItem, _:KItem, _:Map, _:ReflectionType)  // This may be needed only for addressToUserID, in init.
        ~> (.K => lazyConcretizeKeysFreezer)
        ~> K:KItem
    requires notBool isLazyConcretize(K)
    [priority(20)]
  rule (M:Map ~> lazyConcretizeKeysFreezer) => (lazyConcretizeKeys(M) ~> M)
    [priority(20)]
endmodule
