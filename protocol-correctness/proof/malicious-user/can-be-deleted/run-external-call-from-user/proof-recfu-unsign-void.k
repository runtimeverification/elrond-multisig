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
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(unsign ( ActionId:Usize ))
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
              ActionData:Map,
              OldActionSigners:Map,
              address(MaliciousAddress:Int),
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
              ActionData,
              ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool ActionId in_keys ( ActionData )
        andBool MaliciousRole ==K BoardMember

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners, UserIdToRole)
        andBool actionDataInvariant(ActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)

        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ?NewActionSigners, UserIdToRole)
        andBool actionSignersInvariant(?NewActionSigners)

        andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(?NewActionSigners), usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
