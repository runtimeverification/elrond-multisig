// timeout = eternal
// breadth = 4
//@ proof
require "../../functions/trusted-discard-action-has-signers.k"  //@ Bazel remove
require "../../functions/trusted-discard-action-no-valid-signers.k"  //@ Bazel remove
require "../../functions/trusted-discard-action-no-valid-signers-no-action.k"  //@ Bazel remove

module PROOF-DISCARD-ACTION-2
  imports TRUSTED-DISCARD-ACTION-HAS-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-DISCARD-ACTION-2
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> splitDiscardAction3(ActionId:Usize)
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
              (MaliciousId |-> Proposer _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              MaliciousAddress:Address,
              stack(
                  customStackState(
                      invariantContractState(
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
                      <log><performed-actions>PerformedActions</performed-actions></log>
                  ),
                  .Map,
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
        andBool ActionId in_keys(ActionSigners)
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
