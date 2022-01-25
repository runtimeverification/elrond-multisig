// timeout = eternal
// breadth = 16
//@ proof

require "../../fragments/trusted-make-concrete-value-fragment.k"  //@ Bazel remove
require "../../functions/trusted-run-external-call-sign-existing-signers-not-in-list.k"  //@ Bazel remove
require "../../functions/trusted-sign-existing-signers-not-in-list.k"  //@ Bazel remove
require "../../lemmas/0/bool/trusted-bool-to-int-sum-and-not.k"  //@ Bazel remove
require "../../lemmas/0/list/contains/trusted-list-contains-unsafe-list-to-map-set-square-bracket-3.k"  //@ Bazel remove
require "../../lemmas/0/list/count-can-sign/trusted-count-can-sign-list-to-map-set-square-bracket-3.k"  //@ Bazel remove
require "../../lemmas/0/map/map-keys-are-below-limit/trusted-map-keys-are-below-limit-ignore-property-handling.k"  //@ Bazel remove
require "../../lemmas/0/signers/trusted-only-this-signer-diffs-transitive.k"  //@ Bazel remove
require "trusted-run-external-calls-from-user.k"  //@ Bazel remove

module PROOF-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
  imports TRUSTED-BOOL-TO-INT-SUM-AND-NOT
  imports TRUSTED-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
  imports TRUSTED-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-3
  imports TRUSTED-MAKE-CONCRETE-VALUE-FRAGMENT
  imports TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING
  imports TRUSTED-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE
  imports TRUSTED-RUN-EXTERNAL-CALL-SIGN-EXISTING-SIGNERS-NOT-IN-LIST
  imports TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER
  imports TRUSTED-SIGN-EXISTING-SIGNERS-NOT-IN-LIST

//@ trusted
// module TRUSTED-BOARD-MEMBERS-SIGN-FOR-INTERSPERSED
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports CAN-BE-DELETED-INTERSPERSED-ACTIONS-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT-FUNCTIONS
  imports MAP-INCLUDED-SYNTAX

  claim
    <T><TT>
          <k> boardMembersSignForInterspersed(
                  DeleteActionId:Usize,
                  MaliciousId:Usize,
                  UnprocessedUserRoles:Map,
                  InitialActionSigners:Map,
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
                _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(OldActionLastIndex:Int),
              ( DeleteActionId |-> (RemoveUser(MaliciousAddress) #as DeleteAction:Action)
                  _OldActionData:Map
              ) #as OldActionData:Map,
              ( DeleteActionId |-> 
                    ( [DeleteFirstSignerId:Usize, _Signers:ExpressionCSV]
                      #as Signers:ExpressionList
                    )
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
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(InitialActionSigners[DeleteActionId <- undef])
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToAddressInvariant(UserIdToAddress)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool userIdToRoleInvariant(UnprocessedUserRoles)
        andBool mapsAreReverse(UserIdToAddress, AddressToUserId)
        andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)
        andBool noMapKeyInList(UnprocessedUserRoles[MaliciousId <- undef], Signers)

        andBool mapIncluded(UnprocessedUserRoles, UserIdToRole)
        andBool notBool DeleteFirstSignerId in_keys(UnprocessedUserRoles)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))
        andBool allKeysBecomeKeys(OldActionSigners, OldActionData)

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

        andBool UnprocessedUserRoles[MaliciousId] orDefault MaliciousRole ==K MaliciousRole
        andBool countCanSignFunction(Signers, UserIdToRole)
                    +Int mapCount(UnprocessedUserRoles, MEP.IsValue(BoardMember))
                    +Int boolToInt(
                        MaliciousRole ==K BoardMember
                        andBool notBool #listContainsSafe(Signers, MaliciousId)
                        andBool notBool MaliciousId in_keys(UnprocessedUserRoles)
                    )
                    -Int boolToInt(
                        MaliciousRole ==K BoardMember
                        andBool #listContainsSafe(Signers, MaliciousId)
                        andBool MaliciousId in_keys(UnprocessedUserRoles)
                    )
                ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))
        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    InitialActionSigners[DeleteActionId <- undef],
                    OldActionSigners[DeleteActionId <- undef],
                    UserIdToRole)

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
                    InitialActionSigners[DeleteActionId <- undef],
                    ?NewActionSigners,
                    UserIdToRole)

        andBool countCanSignFunction([DeleteFirstSignerId, ?NewSigners], UserIdToRole)
                ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))
                      -Int boolToInt(
                              MaliciousRole ==K BoardMember
                              andBool notBool #listContainsSafe([DeleteFirstSignerId, ?NewSigners], MaliciousId)
                          )

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
