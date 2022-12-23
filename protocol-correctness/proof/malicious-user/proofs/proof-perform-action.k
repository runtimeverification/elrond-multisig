// timeout = eternal
// breadth = 13
//@ proof
require "../../functions/trusted-perform-action-endpoint-New-marker.k"  //@ Bazel remove
require "../../functions/trusted-perform-action-endpoint-no-quorum-marker.k"  //@ Bazel remove
require "../../functions/trusted-perform-action-endpoint-None-marker.k"  //@ Bazel remove
require "../../functions/trusted-perform-action-endpoint-nothing-marker.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NEW-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NO-QUORUM-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NONE-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NOTHING-MARKER
//@ trusted
// module TRUSTED-PERFORM-ACTION
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE-SYNTAX

    claim <T><TT>
        <k> runExternalCall(from MaliciousAddress run performActionEndpoint(_ActionId:Usize);) ~> K:K </k>
          invariantState(
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
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousInvariant(
            MaliciousAddress,
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
            expand(expanded))
    ensures true
        andBool maliciousInvariant(
            MaliciousAddress,
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
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
