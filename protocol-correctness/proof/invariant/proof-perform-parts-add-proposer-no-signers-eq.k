// timeout = eternal
// breadth = 5
//@ proof
require "../functions/trusted-perform-action-endpoint-add-proposer-BoardMember-eq-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-add-proposer-Proposer-eq-marker.k"  //@ Bazel remove

module PROOF-PERFORM-PARTS-ADD-PROPOSER-NO-SIGNERS-EQ
  imports INVARIANT-EXECUTE

  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-BOARDMEMBER-EQ-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-BOARDMEMBER-NO-QUORUM-EQ-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-PROPOSER-EQ-MARKER
//@ trusted
// module TRUSTED-PERFORM-PARTS-ADD-PROPOSER-NO-SIGNERS-EQ
//   imports INVARIANT-FUNCTIONS
//   imports INSTRUMENTATION-PERFORM-ACTION-ENDPOINT
//@ end

  claim <T><TT>
          <k> splitAddProposer1(CallerAddress)
              ~> call(performActionEndpoint(ActionId:Usize))
              ~> popContext
              ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> splitActionSigners(ActionId:Usize, ActionSigners:Map)
              ~> runExternalCalls(EC:ExternalCommands)
          </k>
          invariantStateStack(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (CallerId |-> CallerRole:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex0:Usize,
              (ActionId |-> AddProposer(CallerAddress) ActionData0:Map) #as ActionData:Map,
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
                          u(Quorum),
                          ActionLastIndex0,
                          ActionData,
                          ActionSigners),
                      <log><performed-actions>PerformedActions</performed-actions></log>
                  ),
                  .Map,
                  .stack),
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              ?NumUsers1:Usize,
              ?UserIdToAddress1:Map,
              ?AddressToUserId1:Map,
              ?NumBoardMembers1:Usize,
              ?NumProposers1:Usize,
              ?UserIdToRole1:Map,
              ?Quorum1:Usize,
              ?ActionLastIndex1:Usize,
              ?ActionData1:Map,
              ?ActionSigners1:Map,
              ?_PerformedActions:List):StateCell
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
            u(Quorum),
            ActionLastIndex0,
            ActionData0,
            ActionSigners,
            expand(expanded))
        andBool (CallerRole ==K BoardMember orBool CallerRole ==K Proposer)
        andBool Quorum
                <=Int countCanSignFunction(
                    toExpressionListOrDefault(ActionSigners[ActionId] orDefault [.], [void, .]),
                    UserIdToRole)
        andBool notBool ActionId in_keys(ActionSigners)
    ensures invariant(
        no-data,
        ?NumUsers1,
        ?UserIdToAddress1,
        ?AddressToUserId1,
        ?NumBoardMembers1,
        ?NumProposers1,
        ?UserIdToRole1,
        ?Quorum1,
        ?ActionLastIndex1,
        ?ActionData1,
        ?ActionSigners1,
        usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
