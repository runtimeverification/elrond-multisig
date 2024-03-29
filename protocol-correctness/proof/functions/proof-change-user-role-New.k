// timeout = long
// breadth = 3
//@ proof
module PROOF-CHANGE-USER-ROLE-NEW
//@ trusted
// module TRUSTED-CHANGE-USER-ROLE-NEW
//@ end
  imports INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX

  claim <T><TT>
          <k> call(changeUserRole(UserAddress:Address, NewRole:UserRole)) ~> K:K
          </k>
          invariantStateFull(
              u(NumUsers:Int),
              UserIdToAddress:Map,
              AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              UserIdToRole:Map,
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
          <k> evaluate(void) ~> K </k>
          invariantStateFull(
              u(NumUsers +Int 1),
              u(NumUsers +Int 1) |-> UserAddress UserIdToAddress,
              UserAddress |-> u(NumUsers +Int 1) AddressToUserId,
              u(NumBoardMembers +Int #if NewRole ==K BoardMember #then 1 #else 0 #fi),
              u(NumProposers +Int #if NewRole ==K Proposer #then 1 #else 0 #fi),
              #if NewRole ==K None #then UserIdToRole #else u(NumUsers +Int 1) |-> NewRole UserIdToRole #fi,
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
      andBool NumUsers >=Int 0
      // TODO: Perhaps replace with unusedIdsInMapValues(AddressToUserId) +
      // something to map values to keys.
      andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToAddress), expand(expanded))
      andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToRole), expand(expanded))

      andBool mapKeysAreOfType(UserIdToRole, rUsize)
      andBool mapKeysAreOfType(UserIdToAddress, rUsize)

      andBool notBool UserAddress in_keys(AddressToUserId)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
