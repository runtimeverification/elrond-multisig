// timeout = moderate
//@ proof
require "../functions/trusted-perform-action-endpoint-add-proposer-Proposer.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-PROPOSER-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-PROPOSER
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-PROPOSER-PROPOSER-MARKER
//@ end

  imports INSTRUMENTATION-PROOF
  imports INVARIANT

  claim <T><TT>
          <k> add-proposer-Proposer.k ~> call(performActionEndpoint(ActionId:Usize)) ~> K:K </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  UserAddress |-> UserId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              NumProposers:Usize,
              (CallerId |-> Role:UserRole
                  UserId |-> Proposer
                  _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionId |-> AddProposer(UserAddress:Address) #as Action:Action
                  ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(void) ~> K:K </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              u(NumBoardMembers),
              NumProposers,
              UserIdToRole,
              u(Quorum),
              ActionLastIndex,
              ActionData,
              ActionSigners[ActionId <- undef],
              CallerAddress,
              Stack,
              ?_Variables:Map,
              ListItem(Action) PerformedActions
              )
        </TT></T>
    requires true
        // perform-from-id
        andBool isKResult(Action)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool Quorum <=Int NumBoardMembers

        // perform-fragment
        andBool actionSignersInvariant(ActionSigners)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool (Role ==K BoardMember orBool Role ==K Proposer)
        andBool Quorum
                <=Int countCanSignFunction(
                    toExpressionListOrDefault(ActionSigners[ActionId] orDefault [.], [void, .]),
                    UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule

