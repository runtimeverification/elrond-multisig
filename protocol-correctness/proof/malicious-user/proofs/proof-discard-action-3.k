// timeout = eternal
// breadth = 9
//@ proof
require "trusted-discard-action-1.k"  //@ Bazel remove
require "trusted-discard-action-2.k"  //@ Bazel remove
require "../../functions/trusted-discard-action-no-signers.k"  //@ Bazel remove
require "../../functions/trusted-discard-action-no-signers-no-action.k"  //@ Bazel remove

module PROOF-DISCARD-ACTION-3
  imports TRUSTED-DISCARD-ACTION-1
  imports TRUSTED-DISCARD-ACTION-2
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-DISCARD-ACTION-3
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> splitDiscardAction2(ActionId:Usize)
              ~> call(discardAction(ActionId))
              ~> popContext
              ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              MaliciousAddress:Address,
              stack(
                  invariantMultisigState(
                      NumUsers,
                      UserIdToAddress,
                      AddressToUserId,
                      NumBoardMembers,
                      NumProposers,
                      UserIdToRole,
                      Quorum,
                      ActionLastIndex,
                      ActionData,
                      ActionSigners),
                  .Map,
                  PerformedActions,
                  .stack
              ),
              .Map,
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
        andBool MaliciousId in_keys(UserIdToRole)
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
            ?ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
