// breadth = 1
//@ proof

require "../../../functions/trusted-sign-caller-proposer.k"  //@ Bazel remove
require "../../../functions/trusted-sign-empty-action.k"  //@ Bazel remove

module PROOF-RECFU-SIGN-ERROR
  imports TRUSTED-SIGN-CALLER-PROPOSER
  imports TRUSTED-SIGN-EMPTY-ACTION
//@ trusted
// module TRUSTED-RECFU-SIGN-ERROR
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(sign(ActionId:Usize))
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
              ActionSigners:Map,
              address(MaliciousAddress:Int),
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> error ~> K </k>
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
        andBool notBool (true
            andBool ActionId in_keys (ActionData)
            andBool MaliciousRole ==K BoardMember
        )

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool actionDataInvariant(ActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
