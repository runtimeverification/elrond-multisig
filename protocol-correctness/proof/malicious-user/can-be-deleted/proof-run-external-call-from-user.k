//@ proof

module PROOF-RUN-EXTERNAL-CALL-FROM-USER
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
              (MaliciousId |-> _MaliciousRole:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(ActionLastIndex:Int),
              _OldActionData:Map,
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
              ?_NewActionData,
              ?NewActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners)

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
