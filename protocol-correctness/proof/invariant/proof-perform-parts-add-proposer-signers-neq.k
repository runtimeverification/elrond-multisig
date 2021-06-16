// timeout = eternal
// breadth = 4
//@ proof
require "../functions/trusted-perform-action-endpoint-add-proposer-BoardMember-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-add-proposer-Proposer-marker.k"  //@ Bazel remove

module PROOF-PERFORM-PARTS-ADD-PROPOSER-SIGNERS-NEQ
  imports INVARIANT-EXECUTE

  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-BOARDMEMBER-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-BOARDMEMBER-NO-QUORUM-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-PROPOSER-MARKER
//@ trusted
// module TRUSTED-PERFORM-PARTS-ADD-PROPOSER-SIGNERS-NEQ
//   imports INVARIANT-FUNCTIONS
//   imports INSTRUMENTATION-PERFORM-ACTION-ENDPOINT
//@ end

  claim <T><TT>
          <k> splitAddProposer3(UserAddress)
              ~> call(performActionEndpoint(ActionId:Usize))
              ~> popContext
              ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> splitActionSigners(ActionId:Usize, ActionSigners:Map)
              ~> runExternalCalls(EC:ExternalCommands)
          </k>
          invariantStateStack(
              NumUsers:Usize,
              (CallerId:Usize |-> CallerAddress
                  UserId:Usize |-> UserAddress
                  _UserIdToAddress:Map
              ) #as UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  UserAddress |-> UserId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (CallerId |-> CallerRole:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex0:Usize,
              (ActionId |-> AddProposer(UserAddress) ActionData0:Map) #as ActionData:Map,
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
        andBool notBool UserAddress ==K CallerAddress
        andBool UserId in_keys(UserIdToRole)
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
