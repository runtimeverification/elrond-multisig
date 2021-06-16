require "protocol-correctness/pseudocode.k"
require "protocol-correctness/proof/instrumentation-concretize.k"

module INSTRUMENTATION-PROOF
  imports MAP

  imports PSEUDOCODE

  imports INSTRUMENTATION-CONCRETIZE

  syntax KItem ::= splitBoolean(Bool)
  rule splitBoolean(true) => .K  [label(splitBooleanTrue)]
  rule splitBoolean(false) => .K  [label(splitBooleanFalse)]

  syntax KItem ::= branchK(Bool, K, K)
  rule branchK(true, K:K, _:K) => K  [label(branchKTrue)]
  rule branchK(false, _:K, K:K) => K  [label(branchKFalse)]

  syntax KItem ::= "unsign-new.k"
  syntax KItem ::= "unsign-no-role.k"

  rule unsign-new.k => .K
  rule unsign-no-role.k => .K

  syntax KItem ::= "discard-action-no-user.k"
  syntax KItem ::= "discard-action-no-role.k"

  rule discard-action-no-user.k => .K
  rule discard-action-no-role.k => .K

  syntax PerformBranch ::= "perform-new.k"
  syntax PerformBranch ::= "perform-none.k"
  syntax PerformBranch ::= "perform-no-quorum.k"
  syntax PerformBranch ::= "perform-add-board-member-New.k"
  syntax PerformBranch ::= "perform-add-board-member-None.k"
  syntax PerformBranch ::= "perform-add-board-member-BoardMember.k"
  syntax PerformBranch ::= "perform-add-board-member-Proposer.k"
  syntax PerformBranch ::= "perform-add-board-member-BoardMember-eq.k"
  syntax PerformBranch ::= "perform-add-board-member-Proposer-eq.k"
  syntax PerformBranch ::= "perform-add-proposer-New.k"
  syntax PerformBranch ::= "perform-add-proposer-None.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember-no-quorum.k"
  syntax PerformBranch ::= "perform-add-proposer-Proposer.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember-eq.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember-no-quorum-eq.k"
  syntax PerformBranch ::= "perform-add-proposer-Proposer-eq.k"
  syntax PerformBranch ::= "perform-change-quorum.k"
  syntax PerformBranch ::= "perform-change-quorum-no-quorum.k"
  syntax PerformBranch ::= "perform-nothing.k"
  syntax PerformBranch ::= "perform-remove-user-New.k"
  syntax PerformBranch ::= "perform-remove-user-None.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember-too-few.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer-nobody-left.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer-nobody-left-eq.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer-eq.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember-too-few-eq.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember-eq.k"
  syntax PerformBranch ::= "perform-sc-call.k"
  syntax PerformBranch ::= "perform-sc-deploy.k"
  syntax PerformBranch ::= "perform-send-egld.k"

  syntax KItem ::= PerformBranch

  // TODO: It might be faster to enumerate all cases separately.
  rule _:PerformBranch => .K

  // The Haskell backend sometimes leaves traces of
  // (trusted) claims that failed to apply in the predicate.
  // Sometimes, these traces increase the execution time by a lot,
  // so we have to work around this.
  //
  // The symbols below allow us to wrap those claims in another set of claims,
  // which can be attemped without leaving traces.
  syntax ProofBranch ::= "new.k"
  syntax ProofBranch ::= "none.k"
  syntax ProofBranch ::= "no-quorum.k"
  syntax ProofBranch ::= "add-board-member-New.k"
  syntax ProofBranch ::= "add-board-member-None.k"
  syntax ProofBranch ::= "add-board-member-BoardMember.k"
  syntax ProofBranch ::= "add-board-member-Proposer.k"
  syntax ProofBranch ::= "add-board-member-BoardMember-eq.k"
  syntax ProofBranch ::= "add-board-member-Proposer-eq.k"
  syntax ProofBranch ::= "add-proposer-New.k"
  syntax ProofBranch ::= "add-proposer-None.k"
  syntax ProofBranch ::= "add-proposer-BoardMember.k"
  syntax ProofBranch ::= "add-proposer-BoardMember-no-quorum.k"
  syntax ProofBranch ::= "add-proposer-Proposer.k"
  syntax ProofBranch ::= "add-proposer-BoardMember-eq.k"
  syntax ProofBranch ::= "add-proposer-BoardMember-no-quorum-eq.k"
  syntax ProofBranch ::= "add-proposer-Proposer-eq.k"
  syntax ProofBranch ::= "change-quorum.k"
  syntax ProofBranch ::= "change-quorum-no-quorum.k"
  syntax ProofBranch ::= "nothing.k"
  syntax ProofBranch ::= "remove-user-New.k"
  syntax ProofBranch ::= "remove-user-None.k"
  syntax ProofBranch ::= "remove-user-BoardMember-too-few.k"
  syntax ProofBranch ::= "remove-user-BoardMember.k"
  syntax ProofBranch ::= "remove-user-Proposer-nobody-left.k"
  syntax ProofBranch ::= "remove-user-Proposer.k"
  syntax ProofBranch ::= "remove-user-Proposer-nobody-left-eq.k"
  syntax ProofBranch ::= "remove-user-Proposer-eq.k"
  syntax ProofBranch ::= "remove-user-BoardMember-too-few-eq.k"
  syntax ProofBranch ::= "remove-user-BoardMember-eq.k"
  syntax ProofBranch ::= "sc-call.k"
  syntax ProofBranch ::= "sc-deploy.k"
  syntax ProofBranch ::= "send-egld.k"

  syntax KItem ::= ProofBranch

  // TODO: It might be faster to enumerate all cases separately.
  rule _:ProofBranch => .K

  syntax KItem ::= "propose-sc-deploy-no-user.k"
  syntax KItem ::= "propose-sc-deploy-no-role.k"
  syntax KItem ::= "propose-sc-deploy-role.k"

  rule propose-sc-deploy-no-user.k => .K
  rule propose-sc-deploy-no-role.k => .K
  rule propose-sc-deploy-role.k => .K
endmodule
