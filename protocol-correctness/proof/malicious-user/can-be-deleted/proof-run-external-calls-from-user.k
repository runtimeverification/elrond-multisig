// timeout = long
// breadth = 2
//@ proof

require "trusted-run-external-call-from-user.k"  //@ Bazel remove
require "../../lemmas/0/map/map-keys-are-below-limit/trusted-map-keys-are-below-limit-ignore-property-handling.k"  //@ Bazel remove
require "../../lemmas/0/signers/trusted-only-this-signer-diffs-transitive.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALLS-FROM-USER
  imports TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING
  imports TRUSTED-RUN-EXTERNAL-CALL-FROM-USER
  imports TRUSTED-ONLY-THIS-SIGNER-DIFFS-TRANSITIVE

//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALLS-FROM-USER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  claim <T><TT>
          <k> runExternalCallsFromUser(
                  MaliciousAddress:Address,
                  DeleteActionId:Usize,
                  _Steps:Int,
                  UnprocessedUserRoles:Map,
                  LemmasForCanBeDeletedProof)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              ( MaliciousId |-> MaliciousRole:UserRole
                DeleteFirstSignerId |-> BoardMember
                _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(OldActionLastIndex:Int),
              (DeleteActionId |-> RemoveUser(MaliciousAddress) _OldActionData:Map) #as OldActionData:Map,
              (DeleteActionId |-> ([DeleteFirstSignerId:Usize, _Signers:ExpressionCSV] #as Signers)
                _OldActionSigners:Map
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
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(?NewActionLastIndex),
              DeleteActionId |-> RemoveUser(MaliciousAddress) ?NewActionData,
              DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners:ExpressionCSV]
                ?NewActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(OldActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool userIdToRoleInvariant(UserIdToRole)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool allKeysBecomeKeys(OldActionSigners, OldActionData)

        andBool noMapKeyInList(UnprocessedUserRoles[MaliciousId <- undef], Signers)

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionDataInvariant(DeleteActionId |-> RemoveUser(MaliciousAddress) ?NewActionData)
        andBool actionSignersInvariant(
                    DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                      ?NewActionSigners
                )

        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
                    keysMap(
                        DeleteActionId |-> RemoveUser(MaliciousAddress)
                          ?NewActionData
                    ),
                    usesExpanded)
        andBool mapKeysAreBelowLimitSafe(
                    ?NewActionLastIndex +Int 1,
                    keysMap(
                        DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                          ?NewActionSigners
                    ),
                    usesExpanded)

        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    OldActionSigners,
                    DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners]
                      ?NewActionSigners,
                    UserIdToRole)

        andBool noMapKeyInList(UnprocessedUserRoles[MaliciousId <- undef], [DeleteFirstSignerId:Usize, ?NewSigners])
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
