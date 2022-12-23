// timeout = moderate
// breadth = 10
//@ proof

require "../../../functions/trusted-perform-action-endpoint-no-quorum.k"  //@ Bazel remove
require "../../../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove

module PROOF-RECFU-PERFORM-ACTION-ERROR
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-NO-QUORUM
//@ trusted
// module TRUSTED-RECFU-PERFORM-ACTION-ERROR
//@ end
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-INVARIANT

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(performActionEndpoint(ActionId:Usize))
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
              ActionData,
              ActionSigners,
              uninitialized,
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool ActionId ==K DeleteActionId
        andBool Quorum >Int 1
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool actionSignersInvariant(ActionSigners)
        //andBool actionDataInvariant(ActionData)

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ActionSigners[DeleteActionId <- undef], UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
