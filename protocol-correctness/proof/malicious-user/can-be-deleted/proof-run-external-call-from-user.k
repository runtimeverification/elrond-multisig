//@ proof

require "run-external-call-from-user/trusted-recfu-unsign-error.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-unsign-void.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-FROM-USER
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
              u(ActionLastIndex:Int),
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
              u(ActionLastIndex),
              ?NewActionData,
              ?NewActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners)
        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(?NewActionSigners)

        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners)

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
