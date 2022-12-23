// timeout = moderate
// breadth = 1
//@ proof

require "trusted-discard-action-no-role-marker.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-DISCARD-ACTION-CALLER-NONE
  imports TRUSTED-DISCARD-ACTION-NO-ROLE-MARKER
//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-DISCARD-ACTION-CALLER-NONE
//@ end
  imports INVARIANT

  claim <T><TT>
          <k>
              runExternalCall
                  (from CallerAddress run discardAction(_ActionId:Usize);)
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
      andBool notBool u(0) in_keys(UserIdToRole)
      andBool notBool UserId in_keys(UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
