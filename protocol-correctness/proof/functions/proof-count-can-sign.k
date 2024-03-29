// timeout = moderate
// breadth = 6
//@ proof
require "../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove

module PROOF-COUNT-CAN-SIGN
  imports INVARIANT

  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP

//@ trusted
// module TRUSTED-COUNT-CAN-SIGN
  // imports MAIN-PROOF-EXECUTE
//@ end

  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX

  claim <T> <TT>
          <k>
            call(countCanSign(SignerIds:ExpressionList)) ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List
              )
        </TT> </T>
      => <T> <TT>
          <k>
            evaluate(u(countCanSignFunction(SignerIds, UserIdToRole))) ~> K
          </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              ActionLastIndex,
              ActionData,
              ActionSigners,
              CallerAddress,
              Stack,
              ?_Variables,
              PerformedActions:List)
        </TT> </T>
    requires true
        andBool isKResult(SignerIds)
        andBool listElementsAreUsize(SignerIds)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool listElementsAreDistinctSafe(SignerIds)
    ensures true
  //@ proof
  //@ trusted
  // [trusted]
  //@ end
endmodule
