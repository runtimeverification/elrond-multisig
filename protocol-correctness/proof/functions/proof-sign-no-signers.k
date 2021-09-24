// timeout = eternal
// breadth = 2
//@ proof
module PROOF-SIGN-NO-SIGNERS
//@ trusted
// module TRUSTED-SIGN-NO-SIGNERS
//@ end
    imports INVARIANT
  imports CAST-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX

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
              u(ActionLastIndex:Int),
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
              ActionId |-> [UserId, .] ActionSigners,
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
      andBool mapKeysAreBelowLimit(ActionLastIndex +Int 1, keysMap(ActionData), usesExpanded)

      andBool ActionId in_keys(ActionData)
      andBool notBool ActionId in_keys(ActionSigners)
    ensures true
      andBool usizeToInt(ActionId) <Int ActionLastIndex +Int 1
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
