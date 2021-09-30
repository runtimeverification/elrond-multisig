//@ proof
require "trusted-propose-delete-malicious.k"  //@ Bazel remove
require "trusted-run-external-calls-from-user.k"  //@ Bazel remove

module PROOF-CAN-BE-DELETED
  imports TRUSTED-PROPOSE-DELETE-MALICIOUS
  imports TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER
//@ trusted
// module TRUSTED-CAN-BE-DELETED
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
    imports PSEUDOCODE-CONFIGURATION
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX

  claim <T><TT>
          <k> nop
              ~> pickOtherBoardMember(UserIdToRole, AddressToUserId, UserIdToAddress, MaliciousAddress)
              ~> withPickedUserCall(proposeRemoveUser(MaliciousAddress))

              ~> runExternalCallsFromUser(
                    MaliciousAddress:Address,
                    add(ActionLastIndex, u(1)),
                    _Count1:Int
                )

              ~> allBoardMembersSignForInterspersed(
                    add(ActionLastIndex, u(1)),
                    runExternalCallsFromUser(
                        MaliciousAddress:Address,
                        add(ActionLastIndex, u(1)),
                        _Count:Int
                    )
                )

              ~> runExternalCallsFromUser(MaliciousAddress:Address, add(ActionLastIndex, u(1)), _Count2:Int)

              ~> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(performActionEndpoint(add(ActionLastIndex, u(1))))

              ~> runExternalCallsFromUser(MaliciousAddress:Address, add(ActionLastIndex, u(1)), _Count3:Int)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (UserId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> UserId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              (UserId |-> Role:UserRole UserIdToRoleFinal:Map) #as UserIdToRole:Map,
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
              ?NumBoardMembersFinal:Usize,
              ?NumProposersFinal:Usize,
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
            u(NumBoardMembers),
            u(NumProposers),
            UserIdToRole,
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expand(expanded)))
    ensures true
        andBool ?NumBoardMembersFinal
                ==K
                u(NumBoardMembers
                  -Int #if Role ==K BoardMember #then 1 #else 0 #fi
                )
        andBool ?NumProposersFinal
                ==K
                u(NumProposers
                  -Int #if Role ==K Proposer #then 1 #else 0 #fi
                )

        // andBool maliciousDeleteInvariant(
        //     MaliciousAddress,
        //     NumUsers,
        //     UserIdToAddress,
        //     AddressToUserId,
        //     ?NumBoardMembersFinal,
        //     ?NumProposersFinal,
        //     UserIdToRoleFinal,
        //     u(Quorum),
        //     u(?ActionLastIndex),
        //     ?ActionData,
        //     ?ActionSigners,
        //     usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
