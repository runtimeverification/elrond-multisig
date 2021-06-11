// timeout = eternal
// breadth = 5
//@ proof
require "trusted-perform-parts-add-proposer-signers-eq.k"  //@ Bazel remove
require "trusted-perform-parts-add-proposer-signers-neq.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-add-proposer-New-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-add-proposer-None-marker.k"  //@ Bazel remove

module PROOF-PERFORM-PARTS-ADD-PROPOSER-SIGNERS
  imports INVARIANT-EXECUTE

  imports TRUSTED-PERFORM-PARTS-ADD-PROPOSER-SIGNERS-EQ
  imports TRUSTED-PERFORM-PARTS-ADD-PROPOSER-SIGNERS-NEQ
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-NEW-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-NONE-MARKER
//@ trusted
// module TRUSTED-PERFORM-PARTS-ADD-PROPOSER-SIGNERS
//   imports INVARIANT-FUNCTIONS
//   imports PERFORM-ACTION-ENDPOINT-INSTRUMENTATION
//@ end

  claim <T><TT>
          <k> splitAddProposer(AddProposer(_UserAddress:Address) #as Action:Action)
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
              (ActionId |-> Action ActionData0:Map) #as ActionData:Map,
              (ActionId |-> _Signers:ExpressionList _ActionSigners:Map) #as ActionSigners:Map,
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
            ActionData0,
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
