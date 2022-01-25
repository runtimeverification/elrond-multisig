// timeout = moderate
// breadth = 4
//@ proof

require "trusted-run-external-call-from-user-None.k"  //@ Bazel remove
require "../../lemmas/0/map/map-keys-are-below-limit/trusted-map-keys-are-below-limit-ignore-property-handling.k"  //@ Bazel remove
// require "../../lemmas/0/signers/trusted-only-this-signer-diffs-transitive.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALLS-FROM-USER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-FROM-USER-NONE

  imports TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING

//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER-NONE
//@ end
  imports INVARIANT
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX

  claim <T><TT>
          <k> runExternalCallsFromUser(
                  MaliciousAddress:Address,
                  DeleteActionId:Usize,
                  _Steps:Int,
                  UnprocessedUserRoles:Map,
                  LemmasForNoUserRole)
              => .K
              ...
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
    requires true
        andBool notBool MaliciousId in_keys(UserIdToRole)

        andBool notBool u(0) in_keys(UserIdToRole)

        andBool mapValuesAreKResult(AddressToUserId)
        andBool mapValuesAreOfType(AddressToUserId, rUsize)
        andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)

        andBool mapValuesAreOfType(UserIdToRole, rUserRole)
        andBool mapValuesAreKResult(UserIdToRole)
  
        andBool actionDataInvariant(ActionData)
        andBool actionSignersInvariant(ActionSigners)

    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
