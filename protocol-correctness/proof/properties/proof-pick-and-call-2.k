// timeout = eternal
// breadth = 5
//@ proof
require "../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove
require "../functions/trusted-perform-action-endpoint-change-quorum-with-quorum-marker.k"  //@ Bazel remove
require "../map/trusted-map-semantics.k"  //@ Bazel remove

module PROOF-PICK-AND-CALL-2
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
  imports TRUSTED-MAP-SEMANTICS
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-CHANGE-QUORUM-WITH-QUORUM-MARKER

//@ trusted
// module TRUSTED-PICK-AND-CALL-2
//@ end

  imports MAP-EXECUTE-SYNTAX
  imports PROPERTIES-EXECUTE

  claim <T><TT>
          <k> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(performActionEndpoint(ActionLastIndex))
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
              ( ActionLastIndex |-> ChangeQuorum(u(0))
                  ActionDataFinal:Map
              ) #as ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
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
              ActionLastIndex,
              ActionDataFinal,
              ActionSigners[ActionLastIndex <- undef],
              ListItem(ChangeQuorum(u(0))) PerformedActions):StateCell
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
          expand(expanded))
      andBool NumBoardMembers ==Int 0
      andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember)) ==Int 0

      // TODO: Move everything below to the invariant.
      // andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember))
      //     +Int mapCount(UserIdToRole, MEP.IsValue(Proposer))
      //     >Int 0
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
