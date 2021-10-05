require "protocol-correctness/lib/proof/induction/induction.k"
require "protocol-correctness/lib/proof/unsorted/equality-without-substitution.k"
require "protocol-correctness/lib/functions/list-to-map-set.k"
require "protocol-correctness/proof/base.k"
require "protocol-correctness/proof/execution-proof-helpers.k"
require "protocol-correctness/proof/instrumentation-change-user-role.k"
require "protocol-correctness/proof/instrumentation-concretize.k"
require "protocol-correctness/proof/instrumentation-discard-action.k"
require "protocol-correctness/proof/instrumentation-functions.k"
require "protocol-correctness/proof/instrumentation-lemma.k"
require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/proof/instrumentation-perform-action-add-proposer.k"
require "protocol-correctness/proof/instrumentation-perform-action-endpoint.k"
require "protocol-correctness/proof/instrumentation-perform-action-remove-user.k"
require "protocol-correctness/proof/instrumentation-perform-action-sc-deploy.k"
require "protocol-correctness/proof/instrumentation-perform-split-action.k"
require "protocol-correctness/proof/instrumentation-proof.k"
require "protocol-correctness/proof/instrumentation-propose-sc-deploy.k"
require "protocol-correctness/proof/instrumentation-sign.k"
require "protocol-correctness/proof/instrumentation-unsign.k"
require "protocol-correctness/proof/instrumentation/pushlist/pushlist-instrumentation.k"
require "protocol-correctness/proof/invariant.k"
require "protocol-correctness/proof/named-lemmas/named-lemmas.k"
require "protocol-correctness/pseudocode.k"

module MAIN-PROOF-EXECUTE-NO-LEMMAS-SYNTAX
  imports PSEUDOCODE-SYNTAX
  imports INSTRUMENTATION-LEMMA-SYNTAX

  imports PUSHLIST-INSTRUMENTATION-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  imports NAMED-LEMMAS-SYNTAX
  imports EQUALITY-WITHOUT-SUBSTITUTION-SYNTAX
endmodule

module MAIN-PROOF-EXECUTE-BOOL
  imports BOOL

  // rule B1:Bool orBool _:Bool => true
  //   requires B1
  //   [simplification]
  // rule _:Bool orBool B2:Bool => true
  //   requires B2
  //   [simplification]
  rule B1:Bool orBool B2:Bool => B2
    requires notBool B1
    [simplification]
  // rule B1:Bool orBool B2:Bool => B1
  //   requires notBool B2
  //   [simplification]
endmodule

module MAIN-PROOF-EXECUTE-NO-LEMMAS
  imports MAIN-PROOF-EXECUTE-BOOL
  imports EXECUTION-PROOF-HELPERS
  imports INSTRUMENTATION-PROOF
  imports INSTRUMENTATION-LEMMA

  imports INSTRUMENTATION-MAP
  imports INSTRUMENTATION-SIGN
  imports INSTRUMENTATION-CHANGE-USER-ROLE
  imports INSTRUMENTATION-FUNCTIONS
  imports INSTRUMENTATION-PERFORM-ACTION-ADD-PROPOSER
  imports INSTRUMENTATION-PERFORM-ACTION-SC-DEPLOY
  imports INSTRUMENTATION-PERFORM-ACTION-REMOVE-USER
  imports INSTRUMENTATION-PERFORM-SPLIT-ACTION
  imports INSTRUMENTATION-PROPOSE-SC-DEPLOY
  imports INSTRUMENTATION-DISCARD-ACTION
  imports INSTRUMENTATION-UNSIGN
  imports INSTRUMENTATION-PERFORM-ACTION-ENDPOINT

  imports INDUCTION

  imports BASE
  imports INVARIANT

  imports PUSHLIST-INSTRUMENTATION
  imports NAMED-LEMMAS
  imports EQUALITY-WITHOUT-SUBSTITUTION
  imports LIST-TO-MAP-SET
endmodule
