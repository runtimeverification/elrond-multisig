// breadth = 1
//@ proof

require "trusted-board-members-sign-for-interspersed.k"  //@ Bazel remove

module PROOF-ALL-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
  imports TRUSTED-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
//@ trusted
// module TRUSTED-ALL-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT-FUNCTIONS

  claim <T><TT>
          <k> allBoardMembersSignForInterspersed(
                  DeleteActionId:Usize,
                  MaliciousId:Usize,
                  runExternalCallsFromUser(
                      MaliciousAddress:Address, DeleteActionId:Usize, _Steps:Int)
              )
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              NumProposers:Usize,
              ( MaliciousId |-> MaliciousRole:UserRole
                DeleteFirstSignerId |-> BoardMember
                _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(OldActionLastIndex:Int),
              OldActionData:Map,
              ( DeleteActionId |-> [DeleteFirstSignerId:Usize, .]
                _OldActionSigners
              ) #as OldActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              u(NumBoardMembers),
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(?NewActionLastIndex),
              ?NewActionData,
              DeleteActionId |-> ?NewSigners:ExpressionList
                ?NewActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool NumBoardMembers ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionDataInvariant(?NewActionData)
        andBool actionSignersInvariant(
                    DeleteActionId |-> ?NewSigners ?NewActionSigners
                )

        andBool mapKeysAreBelowLimitSafe(?NewActionLastIndex +Int 1, keysMap(?NewActionData), usesExpanded)
        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
                    keysMap(DeleteActionId |-> ?NewSigners ?NewActionSigners),
                    usesExpanded)

        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    OldActionSigners,
                    DeleteActionId |-> ?NewSigners ?NewActionSigners,
                    UserIdToRole)

        andBool countCanSignFunction(?NewSigners, UserIdToRole)
                ==Int NumBoardMembers
                      -Int 1
                      +Int boolToInt(
                              MaliciousRole ==K BoardMember
                              andBool #listContainsSafe(?NewSigners, MaliciousId)
                          )

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
