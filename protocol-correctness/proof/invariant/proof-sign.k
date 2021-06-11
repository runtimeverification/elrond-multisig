// timeout = eternal
// breadth = 10
//@ proof
require "../instrumentation/pushlist/trusted-push-list-not-empty.k"  //@ Bazel remove
require "../functions/trusted-sign-empty-action.k"  //@ Bazel remove
require "../functions/trusted-sign-caller-not-user.k"  //@ Bazel remove
require "../functions/trusted-sign-caller-none.k"  //@ Bazel remove
require "../functions/trusted-sign-caller-proposer.k"  //@ Bazel remove
require "../functions/trusted-sign-no-signers.k"  //@ Bazel remove
require "../functions/trusted-sign-existing-signers-in-list.k"  //@ Bazel remove
require "../functions/trusted-sign-existing-signers-not-in-list.k"  //@ Bazel remove

module PROOF-SIGN
  imports INVARIANT-EXECUTE
  imports PSEUDOCODE

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
// imports INVARIANT
//@ end

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run sign(_ActionId:Usize);
                      EC:ExternalCommands
                  )
              )
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              u(Quorum:Int),
              ActionLastIndex0:Usize,
              ActionData0:Map,
              ActionSigners0:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              u(Quorum),
              ?ActionLastIndex1:Usize,
              ?ActionData1:Map,
              ?ActionSigners1:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires invariant(
        no-data,
        NumUsers:Usize,
        UserIdToAddress:Map,
        AddressToUserId:Map,
        NumBoardMembers:Usize,
        NumProposers:Usize,
        UserRoles:Map,
        u(Quorum),
        ActionLastIndex0:Usize,
        ActionData0:Map,
        ActionSigners0:Map,
        expand(expanded))
    ensures invariant(
        no-data,
        NumUsers:Usize,
        UserIdToAddress:Map,
        AddressToUserId:Map,
        NumBoardMembers:Usize,
        NumProposers:Usize,
        UserRoles:Map,
        u(Quorum),
        ?ActionLastIndex1:Usize,
        ?ActionData1:Map,
        ?ActionSigners1:Map,
        usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
