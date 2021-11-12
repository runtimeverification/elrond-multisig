// timeout = eternal
// breadth = 17
//@ proof
require "../functions/trusted-unsign-no-action.k"  //@ Bazel remove
require "../functions/trusted-unsign-only-signer.k"  //@ Bazel remove
require "../functions/trusted-unsign-other-signers-not-first.k"  //@ Bazel remove
require "../functions/trusted-unsign-other-signers-first.k"  //@ Bazel remove
require "../functions/trusted-unsign-not-signed.k"  //@ Bazel remove
require "../functions/trusted-unsign-no-signers.k"  //@ Bazel remove
require "../functions/trusted-unsign-Proposer.k"  //@ Bazel remove
require "../functions/trusted-unsign-no-role-marker.k"  //@ Bazel remove
require "../functions/trusted-unsign-no-user-marker.k"  //@ Bazel remove

module PROOF-UNSIGN
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-UNSIGN-NO-ACTION
  imports TRUSTED-UNSIGN-ONLY-SIGNER
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-NOT-FIRST
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-FIRST
  imports TRUSTED-UNSIGN-NOT-SIGNED
  imports TRUSTED-UNSIGN-NO-SIGNERS
  imports TRUSTED-UNSIGN-PROPOSER
  imports TRUSTED-UNSIGN-NO-ROLE-MARKER
  imports TRUSTED-UNSIGN-NO-USER-MARKER
//@ trusted
// module TRUSTED-UNSIGN
// imports INVARIANT
//@ end

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run unsign(_ActionId:Usize);
                      EC:ExternalCommands
                  )
              )
          </k>
          invariantState(
              u(NumUsers:Int),
              UserIdToAddress:Map,
              AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              UserRoles:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners0:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              u(NumUsers),
              UserIdToAddress,
              AddressToUserId,
              u(NumBoardMembers),
              u(NumProposers),
              UserRoles,
              u(Quorum),
              ActionLastIndex,
              ActionData,
              ?ActionSigners1:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires invariant(
        no-data,
        u(NumUsers),
        UserIdToAddress,
        AddressToUserId,
        u(NumBoardMembers),
        u(NumProposers),
        UserRoles,
        u(Quorum),
        ActionLastIndex,
        ActionData,
        ActionSigners0,
        expand(expanded))
    ensures invariant(
        no-data,
        u(NumUsers),
        UserIdToAddress,
        AddressToUserId,
        u(NumBoardMembers),
        u(NumProposers),
        UserRoles,
        u(Quorum),
        ActionLastIndex,
        ActionData,
        ?ActionSigners1,
        usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
