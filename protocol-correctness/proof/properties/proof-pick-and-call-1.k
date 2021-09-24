// timeout = eternal
// breadth = 3
// 2021-06-11: Failing because of https://github.com/kframework/kore/issues/2564
//@ proof
require "../functions/trusted-perform-action-endpoint-change-quorum-with-quorum-marker.k"  //@ Bazel remove
require "../map/trusted-map-semantics.k"  //@ Bazel remove

module PROOF-PICK-AND-CALL-1
  imports TRUSTED-MAP-SEMANTICS
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-CHANGE-QUORUM-WITH-QUORUM-MARKER

//@ trusted
// module TRUSTED-PICK-AND-CALL-1
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
              ( ActionLastIndex |-> Signatures:ExpressionList
                  ActionSignersFinal:Map
              ) #as ActionSigners:Map,
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
              ActionSignersFinal,
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
      andBool countCanSignFunction(Signatures, UserIdToRole)
              ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))
      andBool NumBoardMembers >Int 0

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
