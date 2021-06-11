// timeout = long
// breadth = 3
//@ proof
require "../map/trusted-map-semantics.k"  //@ Bazel remove

module PROOF-BOARD-MEMBERS-SIGN-FOR-3
  imports MAP-EXECUTE
  imports PROPERTIES-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-MAP-SEMANTICS
//@ trusted
// module TRUSTED-BOARD-MEMBERS-SIGN-FOR-3
//   imports PROPERTIES-EXECUTE
//   imports PSEUDOCODE
//@ end

  claim <T><TT>
          <k> boardMembersSignFor(ActionIndex:Usize, PartialUserRoles:Map)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              (ActionIndex |-> _Action:KItem _ActionData:Map) #as ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K:K </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserRoles,
              Quorum,
              ActionLastIndex,
              ActionData,
              ActionSigners,
              PerformedActions):StateCell
        </TT></T>
    requires invariant(
            no-data,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserRoles,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expanded))

        // andBool newUserIdToRoleInvariant(PartialUserRoles, UserIdToAddress)
        // andBool userIdToAddressInvariant(UserIdToAddress, AddressToUserId)
        andBool mapsAreReverse(AddressToUserId, UserIdToAddress)
        andBool mapIncluded(PartialUserRoles, UserRoles)
        andBool valuesAreNotEmpty(ActionData, rAction)

        andBool notBool ActionIndex in_keys(ActionSigners)
        andBool mapCount(PartialUserRoles, MEP.IsValue(BoardMember)) <=Int 0
        andBool notBool (PartialUserRoles ==K .Map)

    ensures 0 ==Int mapCount(PartialUserRoles, MEP.IsValue(BoardMember))
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
