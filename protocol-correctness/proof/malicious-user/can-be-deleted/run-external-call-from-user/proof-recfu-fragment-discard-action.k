// timeout = long
// breadth = 6
//@ proof

require "trusted-recfu-discard-action-error-eq.k"  //@ Bazel remove
require "trusted-recfu-discard-action-error-ne.k"  //@ Bazel remove
// require "trusted-recfu-discard-action-void-eq.k"  //@ Bazel remove
require "trusted-recfu-discard-action-void-ne.k"  //@ Bazel remove

require "../../../fragments/trusted-make-concrete-value-fragment.k"  //@ Bazel remove

module PROOF-RECFU-FRAGMENT-DISCARD-ACTION
  imports TRUSTED-RECFU-DISCARD-ACTION-ERROR-EQ
  imports TRUSTED-RECFU-DISCARD-ACTION-ERROR-NE
  // imports TRUSTED-RECFU-DISCARD-ACTION-VOID-EQ
  imports TRUSTED-RECFU-DISCARD-ACTION-VOID-NE

  imports TRUSTED-MAKE-CONCRETE-VALUE-FRAGMENT

//@ trusted
// module TRUSTED-RECFU-FRAGMENT-DISCARD-ACTION
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
              concretizeValue(ActionId:Usize )
              ~> concretizeValue(ActionId ==K DeleteActionId)
              ~> branchK(
                  ActionId ==K DeleteActionId
                      orBool (ActionId in_keys (ActionSignersRemainder:Map)),
                  makeConcreteValue(
                      ActionId,
                      rExpressionList,
                      OldActionSigners
                    ),
                  .K)
              ~> runExternalCall(
                  from MaliciousAddress:Address run discardAction(ActionId);
                )
              ~> concretizeExpressionList(
                    toExpressionListOrDefault(
                        OldActionSigners[ActionId] orDefault [.],
                        [.]
                    ),
                  1
                )
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
              u(ActionLastIndex:Int),
              OldActionData:Map,
              ( DeleteActionId |-> [DeleteFirstSignerId:Usize, _Signers:ExpressionCSV] #as Signers
                ActionSignersRemainder
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
              u(ActionLastIndex),
              ?NewActionData:Map,
              DeleteActionId |-> Signers:ExpressionList ?NewActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(DeleteActionId |-> Signers ?NewActionSigners)

        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1,
                    keysMap(?NewActionData),
                    usesExpanded)

        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1,
                    keysMap(DeleteActionId |-> Signers ?NewActionSigners),
                    usesExpanded
                )

        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    OldActionSigners,
                    DeleteActionId |-> Signers ?NewActionSigners,
                    UserIdToRole
                )

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
