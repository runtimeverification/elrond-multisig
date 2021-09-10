// timeout = eternal
// breadth = 20
//@ proof
require "trusted-discard-action.k"  //@ Bazel remove
require "trusted-perform-action.k"  //@ Bazel remove
require "trusted-propose-add-board-member.k"  //@ Bazel remove
require "trusted-propose-add-proposer.k"  //@ Bazel remove
require "trusted-propose-change-quorum.k"  //@ Bazel remove
require "trusted-propose-remove-user.k"  //@ Bazel remove
require "trusted-propose-sc-call.k"  //@ Bazel remove
require "trusted-propose-sc-deploy.k"  //@ Bazel remove
require "trusted-propose-send-egld.k"  //@ Bazel remove
require "trusted-sign.k"  //@ Bazel remove
require "trusted-unsign.k"  //@ Bazel remove

module PROOF-CALL-INVARIANT
    imports TRUSTED-DISCARD-ACTION
    imports TRUSTED-PERFORM-ACTION
    imports TRUSTED-PROPOSE-ADD-BOARD-MEMBER
    imports TRUSTED-PROPOSE-ADD-PROPOSER
    imports TRUSTED-PROPOSE-CHANGE-QUORUM
    imports TRUSTED-PROPOSE-REMOVE-USER
    imports TRUSTED-PROPOSE-SC-CALL
    imports TRUSTED-PROPOSE-SC-DEPLOY
    imports TRUSTED-PROPOSE-SEND-EGLD
    imports TRUSTED-SIGN
    imports TRUSTED-UNSIGN
//@ trusted
// module TRUSTED-CALL-INVARIANT
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCallFromUser(MaliciousAddress:Address)
              ~> runExternalCallsFromUser(MaliciousAddress:Address, Count:Int)
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
          <k> runExternalCallsFromUser(MaliciousAddress:Address, Count:Int)
              ~> K:K
          </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(?ActionLastIndex:Int),
              ?ActionData:Map,
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
            u(?ActionLastIndex),
            ?ActionData,
            ?ActionSigners,
            //@ proof
            usesExpanded
            //@ trusted
            // expand(expanded)
            //@ end
            )
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
