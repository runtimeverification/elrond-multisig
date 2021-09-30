//@ proof
// Not working because of https://github.com/kframework/kore/issues/2829

require "../../../functions/trusted-unsign-no-signers.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-not-signed.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-only-signer.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-other-signers-first.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-other-signers-not-first.k"  //@ Bazel remove

module PROOF-RECFU-UNSIGN-VOID
  imports TRUSTED-UNSIGN-NO-SIGNERS
  imports TRUSTED-UNSIGN-NOT-SIGNED
  imports TRUSTED-UNSIGN-ONLY-SIGNER
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-FIRST
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-NOT-FIRST
//@ trusted
// module TRUSTED-RECFU-UNSIGN-VOID
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(unsign(UnsignActionId:Usize))
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
              (DeleteActionId |-> Signers:ExpressionList _OldActionSigners:Map) #as OldActionSigners:Map,
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
              DeleteActionId |-> ?Signers:ExpressionList ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool UnsignActionId in_keys ( ActionData )
        andBool MaliciousRole ==K BoardMember

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(ActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, DeleteActionId |-> ?Signers ?NewActionSigners, UserIdToRole)

        andBool actionSignersInvariant(DeleteActionId |-> ?Signers ?NewActionSigners)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(DeleteActionId |-> ?Signers ?NewActionSigners), usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
