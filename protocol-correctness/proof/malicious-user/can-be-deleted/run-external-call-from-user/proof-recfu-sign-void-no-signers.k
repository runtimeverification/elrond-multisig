//@ proof
require "../../../functions/trusted-sign-no-signers.k"  //@ Bazel remove

module PROOF-RECFU-SIGN-VOID-NO-SIGNERS
  imports TRUSTED-SIGN-NO-SIGNERS
//@ trusted
// module TRUSTED-RECFU-SIGN-VOID-NO-SIGNERS
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(sign(ActionId:Usize))
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
          <k> evaluate(void) ~> K </k>
          invariantStateStack(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex),
              ActionData,
              ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool ActionId in_keys ( ActionData )
        andBool MaliciousRole ==K BoardMember
        andBool notBool ActionId in_keys(OldActionSigners)

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners)
        andBool Quorum >Int 1

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool actionDataInvariant(ActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionData), usesExpanded)

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners)
        andBool actionSignersInvariant(?NewActionSigners)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
