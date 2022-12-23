// timeout = eternal
// breadth = 7
//@ proof
require "trusted-board-members-sign-for.k"  //@ Bazel remove
require "trusted-board-members-sign-for-2.k"  //@ Bazel remove
require "trusted-board-members-sign-for-3.k"  //@ Bazel remove
require "trusted-pick-and-call-1.k"  //@ Bazel remove
require "trusted-pick-and-call-2.k"  //@ Bazel remove

require "../map/trusted-map-semantics.k"  //@ Bazel remove

require "../functions/trusted-count-can-sign.k"  //@ Bazel remove
require "../functions/trusted-propose-action-BoardMember.k"  //@ Bazel remove
require "../functions/trusted-propose-action-Proposer.k"  //@ Bazel remove
require "../functions/trusted-propose-action-error-no-user.k"  //@ Bazel remove
require "../functions/trusted-propose-action-error-no-role.k"  //@ Bazel remove

module PROOF-CAN-PROPOSE-AND-EXECUTE
  // imports MAP-EXECUTE
  imports PROPERTIES-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-BOARD-MEMBERS-SIGN-FOR
  imports TRUSTED-BOARD-MEMBERS-SIGN-FOR-2
  imports TRUSTED-BOARD-MEMBERS-SIGN-FOR-3
  imports TRUSTED-PICK-AND-CALL-1
  imports TRUSTED-PICK-AND-CALL-2

  imports TRUSTED-COUNT-CAN-SIGN
  imports TRUSTED-MAP-SEMANTICS

  imports TRUSTED-PROPOSE-ACTION-ERROR-NO-ROLE
  imports TRUSTED-PROPOSE-ACTION-ERROR-NO-USER
  imports TRUSTED-PROPOSE-ACTION-BOARDMEMBER
  imports TRUSTED-PROPOSE-ACTION-PROPOSER
//@ trusted
// module TRUSTED-CAN-PROPOSE-AND-EXECUTE
//   imports PROPERTIES-EXECUTE
//   imports PSEUDOCODE
//@ end
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX

  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MAPS-ARE-REVERSE-SYNTAX

  claim <T><TT>
          <k> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(proposeChangeQuorum(u(0)))
              ~> allBoardMembersSignFor(add(ActionLastIndex, u(1)))
              ~> normalizeActionSigners
              ~> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(performActionEndpoint(add(ActionLastIndex, u(1))))
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              u(NumBoardMembers:Int),
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              _PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> .K </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              u(NumBoardMembers),
              NumProposers,
              UserIdToRole,
              u(0),
              add(ActionLastIndex, u(1)),
              ActionData,
              ActionSigners,
              ?_PerformedActions:List):StateCell
        </TT></T>
    requires invariant(
          no-data,
          NumUsers,
          UserIdToAddress,
          AddressToUserId,
          u(NumBoardMembers),
          NumProposers,
          UserIdToRole,
          Quorum,
          ActionLastIndex,
          ActionData,
          ActionSigners,
          expand(expand(expanded)))
      // TODO: Move everything below to the invariant.
      andBool mapValuesAreOfType(UserIdToAddress, rAddress)
      andBool mapValuesAreKResult(UserIdToAddress)

      // andBool newUserIdToRoleInvariant(UserIdToRole, UserIdToAddress)
      // andBool userIdToAddressInvariant(UserIdToAddress, AddressToUserId)
      andBool mapsAreReverse(AddressToUserId, UserIdToAddress)

      andBool mapValuesAreNotEmpty(ActionData, rAction)

      // andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember))
      //     +Int mapCount(UserIdToRole, MEP.IsValue(Proposer))
      //     >Int 0
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
