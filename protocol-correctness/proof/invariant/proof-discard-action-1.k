// timeout = eternal
// breadth = 8
//@ proof
require "../functions/trusted-discard-action-has-signers.k"  //@ Bazel remove
require "../functions/trusted-discard-action-no-valid-signers.k"  //@ Bazel remove
require "../functions/trusted-discard-action-no-valid-signers-no-action.k"  //@ Bazel remove
require "../lemmas/0/bool/trusted-lemma-bool-to-int-ge-0.k"  //@ Bazel remove
require "../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove

module PROOF-DISCARD-ACTION-1
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-LEMMA-BOOL-TO-INT-GE-0
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
  imports TRUSTED-DISCARD-ACTION-HAS-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-DISCARD-ACTION-1
//   imports INVARIANT-FUNCTIONS
//   imports INSTRUMENTATION-DISCARD-ACTION
//@ end

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
              (CallerAddress |-> CallerId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (CallerId |-> BoardMember _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
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
        andBool invariant(
            no-data,
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
        andBool invariant(
            no-data,
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
