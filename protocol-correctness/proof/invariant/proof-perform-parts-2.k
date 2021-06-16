// timeout = eternal
// breadth = 7
//@ proof
require "trusted-perform-parts-add-board-member.k"  //@ Bazel remove
require "trusted-perform-parts-add-proposer-signers.k"  //@ Bazel remove
require "trusted-perform-parts-add-proposer-no-signers.k"  //@ Bazel remove
require "trusted-perform-parts-change-quorum.k"  //@ Bazel remove
require "trusted-perform-parts-remove-user.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-sc-call-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-sc-deploy-marker.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-send-egld-marker.k"  //@ Bazel remove

module PROOF-PERFORM-PARTS-2
  imports INVARIANT-EXECUTE

  imports TRUSTED-PERFORM-PARTS-ADD-BOARD-MEMBER
  imports TRUSTED-PERFORM-PARTS-ADD-PROPOSER-SIGNERS
  imports TRUSTED-PERFORM-PARTS-ADD-PROPOSER-NO-SIGNERS
  imports TRUSTED-PERFORM-PARTS-CHANGE-QUORUM
  imports TRUSTED-PERFORM-PARTS-REMOVE-USER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-SC-CALL-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-SC-DEPLOY-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-SEND-EGLD-MARKER
//@ trusted
// module TRUSTED-PERFORM-PARTS-2
//   imports INVARIANT-FUNCTIONS
//   imports INSTRUMENTATION-PERFORM-ACTION-ENDPOINT
//@ end

  claim <T><TT>
          <k> splitAction(Action:Action)
              ~> splitPerformActionEndpoint4(Action)
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
        andBool Quorum <=Int 0
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
