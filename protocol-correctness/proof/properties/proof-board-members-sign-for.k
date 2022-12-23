// timeout = eternal
// breadth = 3
//@ proof
require "../map/trusted-map-semantics.k"  //@ Bazel remove

require "../instrumentation/pushlist/trusted-push-list-not-empty.k"  //@ Bazel remove
require "../functions/trusted-sign-empty-action.k"  //@ Bazel remove
require "../functions/trusted-sign-caller-not-user.k"  //@ Bazel remove
require "../functions/trusted-sign-caller-none.k"  //@ Bazel remove
require "../functions/trusted-sign-caller-proposer.k"  //@ Bazel remove
require "../functions/trusted-sign-no-signers.k"  //@ Bazel remove
require "../functions/trusted-sign-existing-signers-in-list.k"  //@ Bazel remove
require "../functions/trusted-sign-existing-signers-not-in-list.k"  //@ Bazel remove
require "../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove

module PROOF-BOARD-MEMBERS-SIGN-FOR
  // imports MAP-EXECUTE
  imports PROPERTIES-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
  imports TRUSTED-MAP-SEMANTICS
  imports TRUSTED-PUSH-LIST-NOT-EMPTY
  imports TRUSTED-SIGN-EMPTY-ACTION
  imports TRUSTED-SIGN-CALLER-NOT-USER
  imports TRUSTED-SIGN-CALLER-NONE
  imports TRUSTED-SIGN-CALLER-PROPOSER
  imports TRUSTED-SIGN-NO-SIGNERS
  imports TRUSTED-SIGN-EXISTING-SIGNERS-IN-LIST
  imports TRUSTED-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
//@ trusted
// module TRUSTED-BOARD-MEMBERS-SIGN-FOR
//   imports PROPERTIES-EXECUTE
//   imports PSEUDOCODE
//@ end

  imports MAP-EXECUTE-SYNTAX
  imports MAP-INCLUDED-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAPS-ARE-REVERSE-SYNTAX
  imports NO-MAP-KEY-IN-LIST-SYNTAX

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
              ActionIndex |-> Signatures:ExpressionList ActionSigners:Map,
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
              ActionIndex |-> ?Signatures ActionSigners,
              PerformedActions:List):StateCell
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
            ActionIndex |-> Signatures ActionSigners,
            expand(expanded))

        // andBool newUserIdToRoleInvariant(PartialUserRoles, UserIdToAddress)
        // andBool userIdToAddressInvariant(UserIdToAddress, AddressToUserId)
        andBool mapsAreReverse(AddressToUserId, UserIdToAddress)
        andBool mapIncluded(PartialUserRoles, UserRoles)
        andBool mapValuesAreNotEmpty(ActionData, rAction)
        andBool noMapKeyInList(PartialUserRoles, Signatures)
    ensures invariant(
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
            ActionIndex |-> ?Signatures ActionSigners,
            usesExpanded)
        andBool countCanSignFunction(?Signatures, UserRoles)
                ==Int mapCount(PartialUserRoles, MEP.IsValue(BoardMember))
                      +Int countCanSignFunction(Signatures, UserRoles)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
