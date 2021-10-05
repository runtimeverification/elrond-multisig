// timeout = eternal
// breadth = 31
// Fails because it takes ~65 minutes to run. Should extract part of it.
//@ proof
require "trusted-call-invariant-fragment-sign.k"  //@ Bazel remove
require "trusted-call-invariant-fragment-unsign.k"  //@ Bazel remove
require "trusted-call-invariant-suffix-fragment.k"  //@ Bazel remove
require "trusted-discard-action.k"  //@ Bazel remove
require "trusted-perform-action.k"  //@ Bazel remove
require "trusted-propose-add-board-member.k"  //@ Bazel remove
require "trusted-propose-add-proposer.k"  //@ Bazel remove
require "trusted-propose-change-quorum.k"  //@ Bazel remove
require "trusted-propose-remove-user.k"  //@ Bazel remove
require "trusted-propose-sc-call.k"  //@ Bazel remove
require "trusted-propose-sc-deploy.k"  //@ Bazel remove
require "trusted-propose-send-egld.k"  //@ Bazel remove

require "../../fragments/trusted-make-concrete-value-fragment.k"  //@ Bazel remove

module PROOF-CALL-INVARIANT-IN-KEYS
    imports TRUSTED-CALL-INVARIANT-FRAGMENT-SIGN
    imports TRUSTED-CALL-INVARIANT-FRAGMENT-UNSIGN
    imports TRUSTED-CALL-INVARIANT-SUFFIX-FRAGMENT
    imports TRUSTED-DISCARD-ACTION
    imports TRUSTED-MAKE-CONCRETE-VALUE-FRAGMENT
    imports TRUSTED-PERFORM-ACTION
    imports TRUSTED-PROPOSE-ADD-BOARD-MEMBER
    imports TRUSTED-PROPOSE-ADD-PROPOSER
    imports TRUSTED-PROPOSE-CHANGE-QUORUM
    imports TRUSTED-PROPOSE-REMOVE-USER
    imports TRUSTED-PROPOSE-SC-CALL
    imports TRUSTED-PROPOSE-SC-DEPLOY
    imports TRUSTED-PROPOSE-SEND-EGLD

//@ trusted
// module TRUSTED-CALL-INVARIANT-IN-KEYS
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCallFromUser(MaliciousAddress:Address, u(0) #as ActionId:Usize)
              ~> actionDataKeysAreBelowLimitConvertExpanded
              ~> actionSignersKeysAreBelowLimitConvertExpanded
              ~> concretizeDeleteActionSigners(ActionId)
              ~> passSigners
              ~> (runExternalCallsFromUser(
                      MaliciousAddress:Address, ActionId:Usize, Count:Int
                  ) #as Ruecfu:KItem)
              ~> callLemmaOnlyThisSignerDiffsTransitiveFreezer(
                    MaliciousId:Usize,
                    ActionSigners:Map
                )
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
          <k> Ruecfu
              ~> callLemmaOnlyThisSignerDiffsTransitive(
                    MaliciousId,
                    ActionSigners:Map,
                    ?ActionSigners:Map
                )
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
        andBool MaliciousAddress in_keys(AddressToUserId)
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
