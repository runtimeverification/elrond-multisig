// timeout = eternal
// breadth = 14
//@ proof

require "../../../functions/trusted-discard-action-no-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-signers-no-action.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-valid-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-valid-signers-no-action.k"  //@ Bazel remove

module PROOF-RECFU-DISCARD-ACTION-VOID
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS-NO-ACTION
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-RECFU-DISCARD-ACTION-VOID
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(discardAction(ActionId:Usize))
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
              OldActionData:Map,
              OldActionSigners:Map,
              address(MaliciousAddress:Int) #as CallerAddress:Address,
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
              ?NewActionData,
              ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool u(0) in_keys(UserIdToRole)

        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionDataInvariant(OldActionData)

        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners, UserIdToRole)
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
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners, UserIdToRole)

        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(?NewActionSigners)

        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(?NewActionData), usesExpanded)
        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(?NewActionSigners), usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
