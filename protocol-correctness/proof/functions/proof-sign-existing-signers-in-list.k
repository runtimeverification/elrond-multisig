// timeout = moderate
// breadth = 2
//@ proof
module PROOF-SIGN-EXISTING-SIGNERS-IN-LIST
//@ trusted
// module TRUSTED-SIGN-EXISTING-SIGNERS-IN-LIST
//@ end
    imports INVARIANT

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
              ((ActionId |-> Signers:ExpressionList) _ActionSigners:Map) #as ActionSigners:Map,
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
              ActionSigners,
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
      andBool #listContainsSafe(Signers, UserId)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
