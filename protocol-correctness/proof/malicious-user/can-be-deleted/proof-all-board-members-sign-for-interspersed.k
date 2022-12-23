// timeout = long
// breadth = 3
//@ proof

require "trusted-board-members-sign-for-interspersed.k"  //@ Bazel remove

module PROOF-ALL-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
  imports TRUSTED-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
//@ trusted
// module TRUSTED-ALL-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports CAN-BE-DELETED-INTERSPERSED-ACTIONS-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT-FUNCTIONS

  claim <T><TT>
          <k> allBoardMembersSignForInterspersed(
                  DeleteActionId:Usize,
                  MaliciousId:Usize,
                  runExternalCallsFromUserData(
                      MaliciousAddress:Address,
                      DeleteActionId:Usize,
                      _Steps:Int,
                      LemmasForCanBeDeletedProof)
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
                RemainingUserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(OldActionLastIndex:Int),
              ( DeleteActionId |-> (RemoveUser(MaliciousAddress) #as DeleteAction)
                  _OldActionData:Map
              ) #as OldActionData:Map,
              ( DeleteActionId |->
                    [DeleteFirstSignerId:Usize, _Signers] #as Signers:ExpressionList
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
              DeleteActionId |-> DeleteAction ?NewActionData:Map,
              DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners:ExpressionCSV]
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
        andBool userIdToAddressInvariant(UserIdToAddress)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))
        andBool allKeysBecomeKeys(OldActionSigners, OldActionData)

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

        andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)
        andBool mapsAreReverseHalf(AddressToUserId, UserIdToAddress)
        andBool mapsAreReverseHalf(UserIdToAddress, AddressToUserId)

        andBool DeleteFirstSignerId in_keys(UserIdToAddress)
        andBool listToMapSet(Signers)[MaliciousId <- undef]
                ==K listToMapSet([DeleteFirstSignerId, .])[MaliciousId <- undef]
        andBool ( Signers ==K [DeleteFirstSignerId, .]
                orBool Signers ==K [DeleteFirstSignerId, MaliciousId, .]
                )

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionDataInvariant(DeleteActionId |-> DeleteAction ?NewActionData)
        andBool actionSignersInvariant(
                    DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners] ?NewActionSigners
                )

        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
                    keysMap(DeleteActionId |-> DeleteAction ?NewActionData),
                    usesExpanded)
        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
                    keysMap(DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners] ?NewActionSigners),
                    usesExpanded)

        andBool allKeysBecomeKeys(
                    DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners]
                        ?NewActionSigners,
                    DeleteActionId |-> DeleteAction ?NewActionData)

        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    OldActionSigners[DeleteActionId <- undef],
                    ?NewActionSigners,
                    UserIdToRole)

        andBool countCanSignFunction([DeleteFirstSignerId, ?NewSigners], UserIdToRole)
                ==Int NumBoardMembers
                      -Int boolToInt(
                              MaliciousRole ==K BoardMember
                              andBool notBool #listContainsSafe([DeleteFirstSignerId, ?NewSigners], MaliciousId)
                          )

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
