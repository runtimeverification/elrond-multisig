//@ proof

require "run-external-call-from-user/trusted-recfu-propose-add-board-member.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-add-proposer.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-change-quorum.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-remove-user.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-sc-call.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-sc-deploy.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-send-egld.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-sign-error.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-sign-void-no-signers.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-sign-void-signers.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-unsign-error.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-unsign-void.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-FROM-USER
  imports TRUSTED-RECFU-PROPOSE-ADD-BOARD-MEMBER
  imports TRUSTED-RECFU-PROPOSE-ADD-PROPOSER
  imports TRUSTED-RECFU-PROPOSE-CHANGE-QUORUM
  imports TRUSTED-RECFU-PROPOSE-REMOVE-USER
  imports TRUSTED-RECFU-PROPOSE-SC-CALL
  imports TRUSTED-RECFU-PROPOSE-SC-DEPLOY
  imports TRUSTED-RECFU-PROPOSE-SEND-EGLD
  imports TRUSTED-RECFU-SIGN-ERROR
  imports TRUSTED-RECFU-SIGN-VOID-NO-SIGNERS
  imports TRUSTED-RECFU-SIGN-VOID-SIGNERS
  imports TRUSTED-RECFU-UNSIGN-ERROR
  imports TRUSTED-RECFU-UNSIGN-VOID

//@ trusted
// module TRUSTED-CONCRETIZE-BOARD-MEMBER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT

  claim <T><TT>
          <k> runExternalCallFromUser(MaliciousAddress:Address)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> MaliciousRole:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(OldActionLastIndex:Int),
              OldActionData:Map,
              OldActionSigners:Map,
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
              u(Quorum),
              u(?NewActionLastIndex),
              ?NewActionData,
              ?NewActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

        andBool unusedIdsInMapKeys(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool unusedIdsInMapKeys(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners)
        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(?NewActionSigners)

        andBool unusedIdsInMapKeys(?NewActionLastIndex +Int 1, keysMap(?NewActionData), usesExpanded)
        andBool unusedIdsInMapKeys(?NewActionLastIndex +Int 1, keysMap(?NewActionSigners), usesExpanded)

        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners)

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
