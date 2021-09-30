// timeout = moderate
// breadth = 2
//@ proof

require "trusted-run-external-call-from-user.k"  //@ Bazel remove
require "../../lemmas/0/map/trusted-map-keys-are-below-limit-ignore-property-handling.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALLS-FROM-USER
  imports TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING
  imports TRUSTED-RUN-EXTERNAL-CALL-FROM-USER

//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> runExternalCallsFromUser(
                  MaliciousAddress:Address, ActionId:Usize, _Steps:Int)
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
              (ActionId |-> _Signers:ExpressionList _OldActionSigners) #as OldActionSigners:Map,
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
              ActionId |-> ?NewSigners:ExpressionList ?NewActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[ActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(ActionId |-> ?NewSigners ?NewActionSigners)

        andBool mapKeysAreBelowLimitSafe(?NewActionLastIndex +Int 1, keysMap(?NewActionData), usesExpanded)
        andBool mapKeysAreBelowLimitSafe(?NewActionLastIndex +Int 1, keysMap(?NewActionSigners), usesExpanded)

        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ActionId |-> ?NewSigners ?NewActionSigners, UserIdToRole)

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
