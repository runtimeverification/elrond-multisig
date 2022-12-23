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
require "../lemmas/0/int/trusted-lemma-add-one-if-not-negative.k"  //@ Bazel remove
require "../lemmas/0/list/plistlen/trusted-lemma-plistlen.k"  //@ Bazel remove
require "../lemmas/1/list/contains/trusted-lemma-list-contains-last-to-start.k"  //@ Bazel remove
require "../lemmas/1/list/last/trusted-lemma-last-to-start-kresult.k"  //@ Bazel remove
require "../lemmas/1/list/last/trusted-lemma-last-to-start-usize.k"  //@ Bazel remove
require "../lemmas/1/list/last/trusted-lemma-pound-last.k"  //@ Bazel remove
require "../lemmas/1/list/last/trusted-lemma-pound-last-usize-kitem.k"  //@ Bazel remove
require "../lemmas/1/list/last/trusted-lemma-pound-remove-last-kresult-expression.k"  //@ Bazel remove
require "../lemmas/1/list/last/trusted-lemma-pound-remove-last-usize.k"  //@ Bazel remove
require "../lemmas/2/list/contains/trusted-lemma-list-contains-pound-list-swap-remove-2.k"  //@ Bazel remove
require "../lemmas/2/list/contains/trusted-lemma-list-contains-pound-remove-last-pound-last.k"  //@ Bazel remove
require "../lemmas/2/list/contains/trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-neq.k"  //@ Bazel remove

module PROOF-UNSIGN
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE
  imports TRUSTED-LEMMA-LAST-TO-START-KRESULT
  imports TRUSTED-LEMMA-LAST-TO-START-USIZE
  imports TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST-POUND-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports TRUSTED-LEMMA-PLISTLEN
  imports TRUSTED-LEMMA-POUND-LAST
  imports TRUSTED-LEMMA-POUND-LAST-USIZE-KITEM
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-KRESULT-EXPRESSION
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-USIZE
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
