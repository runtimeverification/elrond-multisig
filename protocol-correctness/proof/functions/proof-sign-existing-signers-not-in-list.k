// timeout = long
// breadth = 2
//@ proof
require "../lemmas/0/list/plistlen/trusted-lemma-plistlen.k"  //@ Bazel remove

module PROOF-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
  imports TRUSTED-LEMMA-PLISTLEN
//@ trusted
// module TRUSTED-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
//@ end
  imports INVARIANT
  imports PUSH-LIST-SYNTAX

  claim <T><TT>
          <k> call(sign(ActionId:Usize)) ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (UserId |-> BoardMember _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              (ActionId |-> [Signers:ExpressionCSV]) ActionSigners:Map,
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
              ActionLastIndex,
              ActionData,
              (ActionId |-> [#pushList(Signers, UserId)]) ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables,
              PerformedActions:List
              ):StateCell
        </TT></T>
    requires true
      andBool notBool u(0) in_keys(UserIdToRole)
      andBool actionDataInvariant(ActionData)
      andBool userIdToRoleInvariant(UserIdToRole)

      andBool ActionId in_keys(ActionData)
      andBool isKResult(Signers)
      andBool notBool #listContainsSafe([Signers], UserId)

    ensures true

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
