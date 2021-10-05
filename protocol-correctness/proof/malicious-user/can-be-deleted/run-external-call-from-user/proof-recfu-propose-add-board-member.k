// timeout = long
// breadth = 2
//@ proof

require "../../../functions/trusted-propose-action-BoardMember.k"  //@ Bazel remove
require "../../../functions/trusted-propose-action-Proposer.k"  //@ Bazel remove

module PROOF-RECFU-PROPOSE-ADD-BOARD-MEMBER
  imports TRUSTED-PROPOSE-ACTION-BOARDMEMBER
  imports TRUSTED-PROPOSE-ACTION-PROPOSER
//@ trusted
// module TRUSTED-RECFU-PROPOSE-ADD-BOARD-MEMBER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(proposeAddBoardMember(Member:Address))
              ~> popContext ~> evaluateReturnValue
              ~> clearExternalCallEnv
              ~> deleteMaliciousUserActionId(ActionId:Usize)
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
              (ActionId |-> Signers:ExpressionList _OldActionSigners:Map) #as OldActionSigners:Map,
              address(MaliciousAddress:Int),
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(u(ActionLastIndex +Int 1))
              ~> clearExternalCallEnv
              ~> deleteMaliciousUserActionId(ActionId:Usize)
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
              u(ActionLastIndex +Int 1),
              ActionData u(ActionLastIndex +Int 1) |-> AddBoardMember(Member),
              ActionId |-> Signers ?NewActionSigners,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool MaliciousRole ==K None
        andBool notBool MaliciousId ==K u(0)
        andBool 1 <Int Quorum

        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[ActionId <- undef], UserIdToRole)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool mapKeysAreOfType(ActionData, rUsize)

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool onlyThisSignerDiffs(MaliciousId, OldActionSigners, ActionId |-> Signers ?NewActionSigners, UserIdToRole)

        andBool actionSignersInvariant(ActionId |-> Signers ?NewActionSigners)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 2, keysMap(ActionId |-> Signers ?NewActionSigners), usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
