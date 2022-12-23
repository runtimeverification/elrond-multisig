// timeout = moderate
// breadth = 3
//@ proof

require "trusted-perform-action-endpoint-None.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-PERFORM-ACTION-ENDPOINT-CALLER-NONE
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NONE
//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-PERFORM-ACTION-ENDPOINT-CALLER-NONE
//@ end
  imports INVARIANT

  claim <T><TT>
          <k>
              runExternalCall
                  (from CallerAddress run performActionEndpoint(_ActionId:Usize);)
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
      andBool actionSignersInvariant(ActionSigners)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
