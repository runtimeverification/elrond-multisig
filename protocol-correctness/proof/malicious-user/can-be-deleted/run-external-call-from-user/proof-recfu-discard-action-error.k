// timeout = long
// breadth = 8
//@ proof

require "../../../functions/trusted-discard-action-has-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-role.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-user.k"  //@ Bazel remove

module PROOF-RECFU-DISCARD-ACTION-ERROR
  imports TRUSTED-DISCARD-ACTION-HAS-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-ROLE
  imports TRUSTED-DISCARD-ACTION-NO-USER
//@ trusted
// module TRUSTED-RECFU-DISCARD-ACTION-ERROR
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
              ActionData:Map,
              (DeleteActionId |-> Signers:ExpressionList _ActionSigners:Map) #as ActionSigners:Map,
              address(MaliciousAddress:Int) #as CallerAddress:Address,
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> error
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
              ActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool u(0) in_keys(UserIdToRole)

        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionDataInvariant(ActionData)

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionSignersInvariant(ActionSigners)

        andBool
                ( ActionId in_keys(ActionSigners)
                andBool countCanSignFunction(
                        toExpressionListOrDefault(
                                ActionSigners[ActionId] orDefault void,
                                [.]
                            ),
                        UserIdToRole
                    ) >Int 0
                )

    ensures true
        // andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners)
        // andBool onlyThisSignerDiffs(MaliciousId, ActionSigners, ?NewActionSigners, UserIdToRole)

        // andBool actionSignersInvariant(?NewActionSigners)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
