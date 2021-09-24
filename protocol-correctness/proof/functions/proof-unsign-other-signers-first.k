// timeout = long
//@ proof
module PROOF-UNSIGN-OTHER-SIGNERS-FIRST
    imports INVARIANT
//@ trusted
// module TRUSTED-UNSIGN-OTHER-SIGNERS-FIRST
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
              ActionId |-> [(UserId, _:Usize, _Signers:ExpressionCSV) #as Signers:ExpressionCSV] ActionSigners:Map,
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
              ActionId |-> [#listSwapRemove(Signers, #listFindSafe([Signers], UserId))] ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables,
              PerformedActions:List
              ):StateCell
        </TT></T>
    requires true
      andBool isKResult(Action)
      andBool valueIsNotEmpty(Action, rAction)
      andBool isKResult(Signers)

      andBool #listFindSafe([Signers], UserId) >=Int 0
      // andBool pListLen([Signers]) >=Int 2
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
