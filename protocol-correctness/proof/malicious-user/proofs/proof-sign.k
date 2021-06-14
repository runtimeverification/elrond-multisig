// timeout = eternal
// breadth = 9
//@ proof
require "../../instrumentation/pushlist/trusted-push-list-not-empty.k"  //@ Bazel remove
require "../../functions/trusted-sign-empty-action.k"  //@ Bazel remove
require "../../functions/trusted-sign-caller-not-user.k"  //@ Bazel remove
require "../../functions/trusted-sign-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-sign-caller-proposer.k"  //@ Bazel remove
require "../../functions/trusted-sign-no-signers.k"  //@ Bazel remove
require "../../functions/trusted-sign-existing-signers-in-list.k"  //@ Bazel remove
require "../../functions/trusted-sign-existing-signers-not-in-list.k"  //@ Bazel remove

module PROOF-SIGN
  imports TRUSTED-PUSH-LIST-NOT-EMPTY
  imports TRUSTED-SIGN-EMPTY-ACTION
  imports TRUSTED-SIGN-CALLER-NOT-USER
  imports TRUSTED-SIGN-CALLER-NONE
  imports TRUSTED-SIGN-CALLER-PROPOSER
  imports TRUSTED-SIGN-NO-SIGNERS
  imports TRUSTED-SIGN-EXISTING-SIGNERS-IN-LIST
  imports TRUSTED-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
//@ trusted
// module TRUSTED-SIGN
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCall(from MaliciousAddress run sign(_ActionId:Usize);) ~> K:K </k>
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
              ActionLastIndex:Usize,
              ActionData:Map,
              ?ActionSigners:Map,
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
            u(Quorum),
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
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
