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
    requires    listElementsAreAddresses(Addresses)

        andBool isKResult(Addresses)
        andBool noReusedIndexAddress(u(1), .Map, Addresses)
        andBool noReusedIndexRole(u(1), .Map, Addresses)

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
