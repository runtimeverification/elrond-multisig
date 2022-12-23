// timeout = eternal
// breadth = 10
//@ proof
require "../../functions/trusted-unsign-no-action.k"  //@ Bazel remove
require "../../functions/trusted-unsign-only-signer.k"  //@ Bazel remove
require "../../functions/trusted-unsign-other-signers-not-first.k"  //@ Bazel remove
require "../../functions/trusted-unsign-other-signers-first.k"  //@ Bazel remove
require "../../functions/trusted-unsign-not-signed.k"  //@ Bazel remove
require "../../functions/trusted-unsign-no-signers.k"  //@ Bazel remove
require "../../functions/trusted-unsign-Proposer.k"  //@ Bazel remove
require "../../functions/trusted-unsign-no-role-marker.k"  //@ Bazel remove
require "../../functions/trusted-unsign-no-user-marker.k"  //@ Bazel remove

module PROOF-UNSIGN
  imports TRUSTED-UNSIGN-NO-ACTION
  imports TRUSTED-UNSIGN-ONLY-SIGNER
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-NOT-FIRST
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-FIRST
  imports TRUSTED-UNSIGN-NOT-SIGNED
  imports TRUSTED-UNSIGN-NO-SIGNERS
  imports TRUSTED-UNSIGN-PROPOSER
  imports TRUSTED-UNSIGN-NO-ROLE-MARKER
  imports TRUSTED-UNSIGN-NO-USER-MARKER
//@ trusted
// module TRUSTED-UNSIGN
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k>
              runExternalCall(from MaliciousAddress run unsign(_ActionId:Usize);)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              ActionLastIndex:Usize,
              ActionData:Map,
              ?ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expanded))
    ensures true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionLastIndex,
            ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
