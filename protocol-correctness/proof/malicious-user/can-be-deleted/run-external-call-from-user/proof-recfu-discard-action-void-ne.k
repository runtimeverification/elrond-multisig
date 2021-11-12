// timeout = eternal
// breadth = 12
//@ proof

require "../../../functions/trusted-discard-action-no-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-signers-no-action.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-valid-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-valid-signers-no-action.k"  //@ Bazel remove

module PROOF-RECFU-DISCARD-ACTION-VOID-NE
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS-NO-ACTION
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-RECFU-DISCARD-ACTION-VOID-NE
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(discardAction(ActionId:Usize))
              ~> popContext ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> concretizeExpressionList(_:ExpressionList, _:Int) #as Cel:KItem
              ~> deleteMaliciousUserActionId(DeleteActionId:Usize)
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
              (DeleteActionId |-> RemoveUser(address(MaliciousAddress)) _OldActionData:Map) #as OldActionData:Map,
              (DeleteActionId |-> Signers:ExpressionList _OldActionSigners:Map) #as OldActionSigners:Map,
              address(MaliciousAddress:Int) #as CallerAddress:Address,
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(void)
              ~> clearExternalCallEnv
              ~> Cel
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
              DeleteActionId |-> RemoveUser(address(MaliciousAddress)) ?NewActionData,
              DeleteActionId |-> Signers:ExpressionList ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool DeleteActionId ==K ActionId
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

        // TODO: Add this everywhere
        andBool allKeysBecomeKeys(OldActionSigners, OldActionData)

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, DeleteActionId |-> Signers:ExpressionList ?NewActionSigners, UserIdToRole)

        andBool actionDataInvariant(DeleteActionId |-> RemoveUser(address(MaliciousAddress)) ?NewActionData)
        andBool actionSignersInvariant(DeleteActionId |-> Signers:ExpressionList ?NewActionSigners)

        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1,
                    keysMap(DeleteActionId |-> RemoveUser(address(MaliciousAddress)) ?NewActionData),
                    usesExpanded
                )
        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(DeleteActionId |-> Signers:ExpressionList ?NewActionSigners), usesExpanded)

        andBool allKeysBecomeKeys(
                    DeleteActionId |-> Signers:ExpressionList ?NewActionSigners,
                    DeleteActionId |-> RemoveUser(address(MaliciousAddress)) ?NewActionData
                )
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
