// timeout = eternal
// breadth = 8
//@ proof

require "trusted-recfu-unsign-error.k"  //@ Bazel remove
require "trusted-recfu-unsign-void-eq.k"  //@ Bazel remove
require "trusted-recfu-unsign-void-neq.k"  //@ Bazel remove

module PROOF-RECFU-FRAGMENT-UNSIGN
  imports TRUSTED-RECFU-UNSIGN-ERROR
  imports TRUSTED-RECFU-UNSIGN-VOID-EQ
  imports TRUSTED-RECFU-UNSIGN-VOID-NEQ

//@ trusted
// module TRUSTED-RECFU-FRAGMENT-UNSIGN
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k>
              branchK(
                  true,
                  makeConcreteValue(
                      MaliciousAddress,
                      rUsize,
                      AddressToUserId:Map
                  )
                  ~> branchK(
                      true,
                      makeConcreteValue(
                          MaliciousId,
                          rUserRole,
                          UserIdToRole:Map
                      ),
                      .K
                  ),
                  .K
              )
              ~> concretizeValue(ActionId)
              ~> concretizeValue(ActionId in_keys (OldActionData:Map))
              ~> concretizeValue(ActionId ==K DeleteActionId)
              ~> runExternalCall(
                  from MaliciousAddress:Address run unsign(ActionId:Usize);)
              ~> deleteMaliciousUserActionId(DeleteActionId:Usize)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              ( MaliciousId |-> MaliciousRole:UserRole
                DeleteFirstSignerId |-> BoardMember
                _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(OldActionLastIndex:Int),
              OldActionData:Map,
              ( DeleteActionId |-> [DeleteFirstSignerId:Usize, _Signers:ExpressionCSV]
                _OldActionSigners
              ) #as OldActionSigners:Map,
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
              u(?NewActionLastIndex:Int),  // TODO: This does not change.
              ?NewActionData:Map,
              DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners:ExpressionCSV]
                ?NewActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

    ensures true
        andBool noQuorumCanBeFilledBy(
            Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(
                    DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                      ?NewActionSigners
                )

        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
                    keysMap(?NewActionData),
                    usesExpanded)
        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
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
