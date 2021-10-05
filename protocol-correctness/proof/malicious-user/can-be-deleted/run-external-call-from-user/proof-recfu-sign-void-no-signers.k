// timeout = long
//@ proof
require "../../../functions/trusted-sign-no-signers.k"  //@ Bazel remove

module PROOF-RECFU-SIGN-VOID-NO-SIGNERS
  imports TRUSTED-SIGN-NO-SIGNERS
//@ trusted
// module TRUSTED-RECFU-SIGN-VOID-NO-SIGNERS
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(sign(ActionId:Usize))
              ~> popContext ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> deleteMaliciousUserActionId(DeleteActionId:Usize)
              ~> K:K
          </k>
          invariantStateStack(
              NumUsers:Usize,
              (MaliciousId |-> address(MaliciousAddress) _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (address(MaliciousAddress) |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              ( MaliciousId |-> MaliciousRole:UserRole
                DeleteFirstSignerId |-> BoardMember
                _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(ActionLastIndex:Int),
              ActionData:Map,
              ( DeleteActionId |-> [DeleteFirstSignerId:Usize, _Signers:ExpressionCSV]
                _OldActionSigners
              ) #as OldActionSigners:Map,
              address(MaliciousAddress:Int),
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(void)
              ~> clearExternalCallEnv
              ~> deleteMaliciousUserActionId(DeleteActionId:Usize)
              ~> K
          </k>
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
              DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners:ExpressionCSV]
                ?NewActionSigners:Map,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool ActionId in_keys ( ActionData )
        andBool MaliciousRole ==K BoardMember
        andBool notBool ActionId in_keys(OldActionSigners)

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool actionDataInvariant(ActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionData), usesExpanded)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionSignersInvariant(
                    DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                      ?NewActionSigners
                )

        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1,
                    keysMap(
                        DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                          ?NewActionSigners
                    ),
                    usesExpanded)

        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    OldActionSigners,
                    DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                      ?NewActionSigners,
                    UserIdToRole)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
