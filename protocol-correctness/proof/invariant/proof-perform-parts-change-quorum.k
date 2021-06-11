// timeout = eternal
// breadth = 6
//@ proof
require "../functions/trusted-perform-action-endpoint-change-quorum-no-quorum-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-change-quorum-with-quorum-marker.k"  //@ Bazel remove

module PROOF-PERFORM-PARTS-CHANGE-QUORUM
  imports INVARIANT-EXECUTE

  imports TRUSTED-PERFORM-ACTION-ENDPOINT-CHANGE-QUORUM-NO-QUORUM-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-CHANGE-QUORUM-WITH-QUORUM-MARKER
//@ trusted
// module TRUSTED-PERFORM-PARTS-CHANGE-QUORUM
//   imports INVARIANT-FUNCTIONS
//   imports PERFORM-ACTION-ENDPOINT-INSTRUMENTATION
//@ end

  claim <T><TT>
          <k> splitPerformActionEndpoint4(ChangeQuorum(_NewQuorum:Usize) #as Action:Action)
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
              (ActionId |-> Action _ActionData:Map) #as ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              stack(
                  invariantMultisigState(
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
                  .Map,
                  PerformedActions,
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
            ActionData,
            ActionSigners,
            expand(expanded))
        andBool (CallerRole ==K BoardMember orBool CallerRole ==K Proposer)
        andBool Quorum
                <=Int countCanSignFunction(
                    toExpressionListOrDefault(ActionSigners[ActionId] orDefault [.], [void, .]),
                    UserIdToRole)
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
