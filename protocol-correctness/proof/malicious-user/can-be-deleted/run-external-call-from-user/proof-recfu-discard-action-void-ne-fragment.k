// breadth = 3
//@ proof

require "../../../functions/trusted-discard-action-no-signers.k"  //@ Bazel remove
require "../../../functions/trusted-discard-action-no-signers-no-action.k"  //@ Bazel remove

module PROOF-RECFU-DISCARD-ACTION-VOID-NE-FRAGMENT
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-RECFU-DISCARD-ACTION-VOID-NE-FRAGMENT
//@ end
  imports FUNCTION-CALL-SYNTAX
  imports INSTRUMENTATION-CONCRETIZE
  imports INSTRUMENTATION-PROOF
  imports INVARIANT
  imports INVARIANT-HELPERS
  imports MAP
  imports MULTISIG-SYNTAX
  // imports CAN-BE-DELETED-EXECUTE-SYNTAX
  // imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  // imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  // imports MALICIOUS-USER-INVARIANT
  // imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> branchK
                ( ActionId in_keys (ActionData)
                , makeConcreteValue(ActionId, rAction, ActionData)
                , .K
                )
              ~> call(discardAction(ActionId:Usize))
              ~> K:K
          </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (UserId |-> Role:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> void ~> K
          </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              ActionLastIndex,
              ActionData[ActionId <- undef],
              ActionSigners,
              CallerAddress,
              Stack:Stack,
              ?_Variables:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
      andBool notBool u(0) in_keys(UserIdToRole)

      andBool userIdToRoleInvariant(UserIdToRole)
      andBool actionDataInvariant(ActionData)

      andBool (Role ==K BoardMember orBool Role ==K Proposer)
      andBool notBool ActionId in_keys(ActionSigners)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
