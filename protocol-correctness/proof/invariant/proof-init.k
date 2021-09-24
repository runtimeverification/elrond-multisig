// timeout = eternal
// breadth = 2
//@ proof
require "trusted-init-loop-error.k"  //@ Bazel remove
require "trusted-init-loop-no-error.k"  //@ Bazel remove
require "../functions/trusted-listlen.k"  //@ Bazel remove

module PROOF-INIT
  imports TRUSTED-INIT-LOOP-ERROR
  imports TRUSTED-INIT-LOOP-NO-ERROR
  imports TRUSTED-LISTLEN
//@ trusted
// module TRUSTED-INIT
//@ end

  imports INVARIANT-EXECUTE
  imports PSEUDOCODE
  imports CAN-ADD-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports CAN-ADD-VALUE-FOR-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports LIST-ELEMENTS-ARE-OF-TYPE-SYNTAX

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run init(_Quorum:Usize, Addresses:ExpressionList);
                      EC:ExternalCommands
                  )
              )
          </k>
          initialState
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              ?NumUsers:Usize,
              ?UserIdToAddress:Map,
              ?AddressToUserId:Map,
              ?NumBoardMembers:Usize,
              ?NumProposers:Usize,
              ?UserIdToRole:Map,
              ?Quorum:Usize,
              ?ActionLastIndex:Usize,
              ?ActionData:Map,
              ?ActionSigners:Map,
              ?PerformedActions:List)
        </TT></T>
    requires    listElementsAreOfType(Addresses, rAddress)

        andBool isKResult(Addresses)
        andBool canAddListElementsAtIndex(u(1), .Map, Addresses)
        andBool canAddValueForListElementsAtIndex(u(1), .Map, Addresses, BoardMember)

    ensures invariant(
        no-data,
          ?NumUsers,
          ?UserIdToAddress,
          ?AddressToUserId,
          ?NumBoardMembers,
          ?NumProposers,
          ?UserIdToRole,
          ?Quorum,
          ?ActionLastIndex,
          ?ActionData,
          ?ActionSigners,
          usesExpanded)
      orBool invariantState(
                ?NumUsers:Usize,
                ?UserIdToAddress:Map,
                ?AddressToUserId:Map,
                ?NumBoardMembers:Usize,
                ?NumProposers:Usize,
                ?UserIdToRole:Map,
                ?Quorum:Usize,
                ?ActionLastIndex:Usize,
                ?ActionData:Map,
                ?ActionSigners:Map,
                ?PerformedActions:List)
              ==K initialState
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
