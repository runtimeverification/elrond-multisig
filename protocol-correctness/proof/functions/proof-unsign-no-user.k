// timeout = moderate
//@ proof
module PROOF-UNSIGN-NO-USER
    imports INVARIANT
//@ trusted
// module TRUSTED-UNSIGN-NO-USER
  // imports MAIN-PROOF-EXECUTE
//@ end

  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> call(unsign(ActionId:Usize)) ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              u(ActionLastIndex:Int),
              (ActionId |-> Action:Action _ActionData:Map) #as ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
      =>
        <T><TT>
          <k> error ~> K </k>
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
      andBool notBool u(0) in_keys(UserIdToRole)

      andBool notBool CallerAddress in_keys(AddressToUserId)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
