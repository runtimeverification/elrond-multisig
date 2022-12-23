// breadth = 2
//@ proof

require "trusted-sign-caller-none.k"  //@ Bazel remove
require "trusted-sign-empty-action.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-SIGN-CALLER-NONE
  imports TRUSTED-SIGN-CALLER-NONE
  imports TRUSTED-SIGN-EMPTY-ACTION
//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-SIGN-CALLER-NONE
//@ end
  imports INVARIANT

  claim <T><TT>
          <k>
              runExternalCall(from CallerAddress run sign(_ActionId:Usize);)
              => .K
              ...
          </k>
          invariantStateFull(
              NumUsers:Usize,
              (UserId |-> CallerAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              uninitialized,
              .stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
    requires true
      andBool notBool UserId in_keys(UserIdToRole)

      andBool notBool u(0) in_keys(UserIdToRole)
      andBool actionDataInvariant(ActionData)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
