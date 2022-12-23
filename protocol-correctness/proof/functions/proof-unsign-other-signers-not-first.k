// timeout = long
//@ proof
require "../lemmas/0/int/trusted-lemma-add-one-if-not-negative-not-zero.k"  //@ Bazel remove
require "../lemmas/0/list/plistlen/trusted-lemma-plistlen.k"  //@ Bazel remove

module PROOF-UNSIGN-OTHER-SIGNERS-NOT-FIRST
    imports INVARIANT
    imports TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE-NOT-ZERO
    imports TRUSTED-LEMMA-PLISTLEN
//@ trusted
// module TRUSTED-UNSIGN-OTHER-SIGNERS-NOT-FIRST
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
              ActionId |-> [(First:Usize, _Signers:ExpressionCSV) #as Signers:ExpressionCSV] ActionSigners:Map,
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
      andBool pListLen([Signers]) >Int 1
      andBool notBool First ==K UserId  // TODO: Combine with the above.
      // andBool pListLen([Signers]) >=Int 2
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
