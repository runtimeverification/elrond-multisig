// timeout = moderate
//@ proof
module PROOF-UNSIGN-ONLY-SIGNER
    imports INVARIANT
//@ trusted
// module TRUSTED-UNSIGN-ONLY-SIGNER
  // imports MAIN-PROOF-EXECUTE
//@ end

  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> call(unsign(ActionId:Usize)) ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (UserId |-> BoardMember _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              u(ActionLastIndex:Int),
              (ActionId |-> Action:Action _ActionData:Map) #as ActionData:Map,
              ActionId |-> [UserId, .] ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
      =>
        <T><TT>
          <k> void ~> K </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(ActionLastIndex),
              ActionData,
              ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables,
              PerformedActions:List
              ):StateCell
        </TT></T>
    requires true
      andBool isKResult(Action)
      andBool valueIsNotEmpty(Action, rAction)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
