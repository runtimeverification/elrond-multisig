// timeout = long
// breadth = 4
//@ proof
require "trusted-call-invariant-in-keys.k"  //@ Bazel remove
require "trusted-call-invariant-not-in-keys.k"  //@ Bazel remove

module PROOF-CANNOT-PERFORM
  imports TRUSTED-CALL-INVARIANT-IN-KEYS
  imports TRUSTED-CALL-INVARIANT-NOT-IN-KEYS
//@ trusted
// module TRUSTED-CANNOT-PERFORM
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCallsFromUser(
                  MaliciousAddress:Address, u(0) #as ActionId:Usize, _Count:Int
              )
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              u(Quorum:Int),
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
              u(Quorum),
              u(?ActionLastIndex:Int),
              ?ActionData:Map,
              ?ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            // UserIdToAddress,
            UserIdToAddress,
            // AddressToUserId,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expanded))

        // andBool Quorum >=Int 2
    ensures true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            // ?UserIdToAddress,
            AddressToUserId,
            // ?AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            u(Quorum),
            u(?ActionLastIndex),
            ?ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
