// timeout = long
// breadth = 30
//@ proof

require "../../functions/trusted-unsign-no-action.k"  //@ Bazel remove
require "../../functions/trusted-unsign-no-role-marker.k"  //@ Bazel remove

require "../../functions/trusted-run-external-call-discard-action-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-perform-action-endpoint-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-add-board-member-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-add-proposer-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-change-quorum-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-remove-user-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-sc-call-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-sc-deploy-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-propose-send-egld-caller-none.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-sign-caller-none.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-FROM-USER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-DISCARD-ACTION-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PERFORM-ACTION-ENDPOINT-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-ADD-BOARD-MEMBER-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-ADD-PROPOSER-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-CHANGE-QUORUM-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-REMOVE-USER-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-SC-CALL-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-SC-DEPLOY-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-PROPOSE-SEND-EGLD-CALLER-NONE
  imports TRUSTED-RUN-EXTERNAL-CALL-SIGN-CALLER-NONE

  imports TRUSTED-UNSIGN-NO-ACTION
  imports TRUSTED-UNSIGN-NO-ROLE-MARKER

//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-FROM-USER-NONE
//@ end
  // imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports INVARIANT
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  // imports MALICIOUS-USER-INVARIANT
  // imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  // imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  // imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> runExternalCallFromUser(
                  MaliciousAddress:Address,
                  _DeleteActionId:Usize,
                  _UnprocessedUserRoles:Map,
                  LemmasForNoUserRole)
              ~> K:K
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
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              ActionLastIndex,
              ActionData,
              ActionSigners,
              PerformedActions):StateCell
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
