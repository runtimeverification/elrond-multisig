require "protocol-correctness/lib/language/base-types.k"

module NAMED-LEMMA-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP

  syntax KItem ::=  lemmaOnlyThisSignerDiffsTransitive(
                        signerId:Usize,
                        oldSigners:Map,
                        intermediateSigners:Map,
                        newSigners:Map,
                        userIdToRole:Map
                    )
endmodule

module NAMED-LEMMA-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE
  imports NAMED-LEMMA-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE-SYNTAX

  rule lemmaOnlyThisSignerDiffsTransitive(
          _SignerId:Usize,
          _OldSigners:Map,
          _IntermediateSigners:Map,
          _NewSigners:Map,
          _UserIdToRole:Map
      ) => .K
endmodule

