// timeout = eternal
// breadth = 6
//@ proof

require "../../../functions/trusted-discard-action-no-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-signers-no-action.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-valid-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-valid-signers-no-action.k"  //@ Bazel remove

// TODO: This should not be needed - the malicious user delete action can't be deleted.

module PROOF-RECFU-DISCARD-ACTION-VOID-EQ
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS-NO-ACTION
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-RECFU-DISCARD-ACTION-VOID-EQ
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(discardAction(ActionId:Usize))
              ~> popContext ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> concretizeExpressionList(Signers, 1)
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
              OldActionData:Map,
              (DeleteActionId |-> Signers:ExpressionList ActionSignersFinal:Map) #as OldActionSigners:Map,
              address(MaliciousAddress:Int) #as CallerAddress:Address,
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantStateStack(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex),
              ?NewActionData,
              ActionSignersFinal,
              uninitialized,
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool DeleteActionId ==K ActionId

        andBool notBool u(0) in_keys(UserIdToRole)

        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionDataInvariant(OldActionData)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool
            ( notBool ActionId in_keys(OldActionSigners)
            orBool
              ( ActionId in_keys(OldActionSigners)
              andBool countCanSignFunction(
                      toExpressionListOrDefault(
                              OldActionSigners[ActionId] orDefault void,
                              [.]
                          ),
                      UserIdToRole
                  ) ==Int 0
              )
            )

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ActionSignersFinal, UserIdToRole)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, DeleteActionId |-> Signers:ExpressionList ActionSignersFinal, UserIdToRole)

        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(DeleteActionId |-> Signers:ExpressionList ActionSignersFinal)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(?NewActionData), usesExpanded)
        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(DeleteActionId |-> Signers:ExpressionList ActionSignersFinal), usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
