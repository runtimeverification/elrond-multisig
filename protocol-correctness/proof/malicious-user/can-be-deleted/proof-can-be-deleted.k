//@ proof
require "trusted-propose-delete-malicious.k"  //@ Bazel remove

module PROOF-CAN-BE-DELETED
  imports TRUSTED-PROPOSE-DELETE-MALICIOUS
//@ trusted
// module TRUSTED-CAN-BE-DELETED
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
    imports PSEUDOCODE-CONFIGURATION
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX

  claim <T><TT>
          <k> pickOtherBoardMember(UserIdToRole, AddressToUserId, UserIdToAddress, MaliciousAddress)
              ~> withPickedUserCall(proposeRemoveUser(MaliciousAddress))

              ~> runExternalCallsFromUser(MaliciousAddress:Address, _Count1:Int)

              ~> allBoardMembersSignForInterspersed(add(ActionLastIndex, u(1)), runExternalCallsFromUser(MaliciousAddress:Address, _Count:Int))

              ~> runExternalCallsFromUser(MaliciousAddress:Address, _Count2:Int)

              ~> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(performActionEndpoint(add(ActionLastIndex, u(1))))

              ~> runExternalCallsFromUser(MaliciousAddress:Address, _Count3:Int)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (MaliciousAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (UserId |-> _Role:UserRole UserIdToRoleFinal:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(?ActionLastIndex:Int),
              ?ActionData:Map,
              ?ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousDeleteInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expanded))
    ensures true
        andBool maliciousDeleteInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRoleFinal,
            u(Quorum),
            u(?ActionLastIndex),
            ?ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
