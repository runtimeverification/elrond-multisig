// timeout = moderate
// breadth = 2
//@ proof

require "../../../functions/trusted-propose-action-BoardMember.k"  //@ Bazel remove
require "../../../functions/trusted-propose-action-Proposer.k"  //@ Bazel remove

module PROOF-RECFU-PROPOSE-ADD-PROPOSER
  imports TRUSTED-PROPOSE-ACTION-BOARDMEMBER
  imports TRUSTED-PROPOSE-ACTION-PROPOSER
//@ trusted
// module TRUSTED-RECFU-PROPOSE-ADD-PROPOSER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(proposeAddProposer(Member:Address))
              ~> popContext ~> evaluateReturnValue
              ~> K:K
          </k>
          invariantStateStack(
              NumUsers:Usize,
              (MaliciousId |-> address(MaliciousAddress) _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (address(MaliciousAddress) |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> MaliciousRole:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(ActionLastIndex:Int),
              ActionData:Map,
              OldActionSigners:Map,
              address(MaliciousAddress:Int),
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(u(ActionLastIndex +Int 1)) ~> K </k>
          invariantStateStack(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex +Int 1),
              ActionData u(ActionLastIndex +Int 1) |-> AddProposer(Member),
              ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool MaliciousRole ==K None
        andBool notBool MaliciousId ==K u(0)
        andBool 1 <Int Quorum

        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners)


        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners)

        andBool actionSignersInvariant(?NewActionSigners)

        andBool unusedIdsInMapKeys(ActionLastIndex +Int 2, keysMap(?NewActionSigners), usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
