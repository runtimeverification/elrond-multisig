// timeout = moderate
// breadth = 1

require "trusted-propose-action-error-no-role.k"  //@ Bazel remove

//@ proof
module PROOF-RUN-EXTERNAL-CALL-PROPOSE-ADD-BOARD-MEMBER-CALLER-NONE
  imports TRUSTED-PROPOSE-ACTION-ERROR-NO-ROLE
//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-ADD-BOARD-MEMBER-CALLER-NONE
//@ end
    imports INVARIANT

  claim <T><TT>
          <k>
              runExternalCall
                  (from CallerAddress run proposeAddBoardMember(_UserAddress:Address);)
              => .K
              ...
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
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

      andBool mapValuesAreKResult(AddressToUserId)
      andBool mapValuesAreOfType(AddressToUserId, rUsize)
      andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)

      andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool mapValuesAreKResult(UserIdToRole)

      andBool notBool UserId in_keys(UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
