// timeout = long
// breadth = 2
//@ proof
require "trusted-count-can-sign.k"  //@ Bazel remove
//@ trusted
//@ end

//@ proof
module PROOF-DISCARD-ACTION-HAS-SIGNERS
  imports INVARIANT
  imports TRUSTED-COUNT-CAN-SIGN
//@ trusted
// module TRUSTED-DISCARD-ACTION-HAS-SIGNERS
  // imports MAIN-PROOF-EXECUTE
//@ end

  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX

  claim <T><TT>
          <k> call(discardAction(ActionId:Usize)) ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (UserId |-> Role:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              (ActionId |-> SignerIds _ActionSigners:Map) #as ActionSigners:Map,
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
              ActionLastIndex:Usize,
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

      andBool isKResult(SignerIds)
      andBool listElementsAreUsize(SignerIds)
      andBool userIdToRoleInvariant(UserIdToRole)
      andBool listElementsAreDistinctSafe(SignerIds)


      andBool (Role ==K BoardMember orBool Role ==K Proposer)
      andBool countCanSignFunction(SignerIds, UserIdToRole) >Int 0
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
