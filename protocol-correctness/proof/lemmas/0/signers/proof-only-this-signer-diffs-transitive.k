// breadth = 1
//@ proof
module PROOF-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE
//@ trusted
// require "protocol-correctness/multisig/lib/functions/only-this-signer-diffs.k"
// require "protocol-correctness/proof/invariant.k"
// module TRUSTED-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE
//@ end

  imports BASE-TYPES-SYNTAX
  imports INVARIANT-HELPERS
  imports MAP
  imports NAMED-LEMMA-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE-SYNTAX
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim lemmaOnlyThisSignerDiffsTransitive(
            SignerId:Usize,
            OldSigners:Map,
            IntermediateSigners:Map,
            NewSigners:Map,
            UserIdToRole:Map
        )
      => .K
    requires true
        andBool actionSignersInvariant(OldSigners)
        andBool actionSignersInvariant(IntermediateSigners)
        andBool actionSignersInvariant(NewSigners)
        andBool onlyThisSignerDiffs(SignerId, OldSigners, IntermediateSigners, UserIdToRole)
        andBool onlyThisSignerDiffs(SignerId, IntermediateSigners, NewSigners, UserIdToRole)
    ensures onlyThisSignerDiffs(SignerId, OldSigners, NewSigners, UserIdToRole)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
