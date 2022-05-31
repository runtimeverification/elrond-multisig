// timeout = long
// breadth = 6
//@ proof
require "trusted-all-board-members-sign-for-interspersed.k"  //@ Bazel remove
require "trusted-execute-delete-malicious.k"  //@ Bazel remove
require "trusted-propose-delete-malicious.k"  //@ Bazel remove
require "trusted-run-external-calls-from-user.k"  //@ Bazel remove
require "trusted-run-external-calls-from-user-None.k"  //@ Bazel remove
require "../proofs/trusted-cannot-perform.k"  //@ Bazel remove
require "../../lemmas/0/map/map-keys-are-below-limit/trusted-map-keys-are-below-limit-ignore-property-handling.k"  //@ Bazel remove
require "../../lemmas/1/list/list-to-map-set/trusted-list-to-map-set-concretize.k"  //@ Bazel remove
require "../../lemmas/2/signers/trusted-count-can-sign-list-to-map-set-square-bracket-3.k"  //@ Bazel remove

module PROOF-CAN-BE-DELETED
  imports TRUSTED-ALL-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
  imports TRUSTED-CANNOT-PERFORM
  imports TRUSTED-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
  imports TRUSTED-EXECUTE-DELETE-MALICIOUS
  imports TRUSTED-LIST-TO-MAP-SET-CONCRETIZE
  imports TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING
  imports TRUSTED-PROPOSE-DELETE-MALICIOUS
  imports TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER
  imports TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER-NONE

//@ trusted
// module TRUSTED-CAN-BE-DELETED
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports CAN-BE-DELETED-INTERSPERSED-ACTIONS-SYNTAX
  imports CAST-SYNTAX
  imports PSEUDOCODE-CONFIGURATION
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX

  claim <T><TT>
          <k> nop
              ~> pickOtherBoardMember(UserIdToRole, AddressToUserId, UserIdToAddress, MaliciousAddress)
              ~> withPickedUserCall(proposeRemoveUser(MaliciousAddress))

              ~> makeConcreteDeleteProposer(add(ActionLastIndex, u(1)))

              ~> runExternalCallsFromUser(
                    MaliciousAddress:Address,
                    add(ActionLastIndex, u(1)),
                    _Count1:Int,
                    .Map,
                    LemmasForCanBeDeletedProof
                )

              ~> callLemmaMapKeysAreBelowLimitIgnoresPropertyHandling(
                    usesExpanded, expand(expanded))
              ~> callLemmaListToMapSetConcretize(
                    add(ActionLastIndex, u(1)),
                    UserId
                )

              ~> allBoardMembersSignForInterspersed(
                    add(ActionLastIndex, u(1)),
                    UserId,
                    runExternalCallsFromUserData(
                        MaliciousAddress:Address,
                        add(ActionLastIndex, u(1)),
                        _Count:Int,
                        LemmasForCanBeDeletedProof
                    )
                )

              ~> callLemmaMapKeysAreBelowLimitIgnoresPropertyHandling(
                    usesExpanded, expand(expanded))

              ~> callLemmaCountCanSignListToMapSetSquareBracket3AfterKItem(
                    add(ActionLastIndex, u(1)),
                    toUsizeOrDefault
                        (AddressToUserId[MaliciousAddress] orDefault void, u(0)))

              ~> runExternalCallsFromUser(
                    MaliciousAddress:Address,
                    add(ActionLastIndex, u(1)),
                    _Count2:Int,
                    .Map,
                    LemmasForCanBeDeletedProof)

              ~> pickOtherBoardMember(UserIdToRole, AddressToUserId, UserIdToAddress, MaliciousAddress)
              // ~> pickFirstSignerAvoiding(add(ActionLastIndex, u(1)), UserId)
              ~> withPickedUserCall(performActionEndpoint(add(ActionLastIndex, u(1))))

              ~> callLemmaMapKeysAreBelowLimitIgnoresPropertyHandlingActionData
                  (usesExpanded, expand(expanded))
              ~> callLemmaMapKeysAreBelowLimitIgnoresPropertyHandlingActionSigners
                  (usesExpanded, expand(expanded))

              ~> runExternalCallsFromUser(
                    MaliciousAddress:Address,
                    add(ActionLastIndex, u(1)),
                    _Count3:Int,
                    .Map,
                    LemmasForNoUserRole)
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
              UserIdToAddress,
              AddressToUserId,
              ?NumBoardMembersFinal:Usize,
              ?NumProposersFinal:Usize,
              UserIdToRoleFinal,
              u(Quorum),
              u(?_ActionLastIndex:Int),
              ?_ActionData,
              ?_ActionSigners,
              ListItem(RemoveUser(MaliciousAddress)) PerformedActions
          ):StateCell
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
        // TODO: Move to the invariant
        andBool allKeysBecomeKeys(ActionSigners, ActionData)
        andBool Quorum
                <=Int NumBoardMembers -Int boolToInt(Role ==K BoardMember)
        andBool usizeToInt(ActionLastIndex) >=Int 0
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
