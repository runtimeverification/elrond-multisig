// timeout = eternal
// breadth = 22
//@ proof

require "run-external-call-from-user/trusted-recfu-fragment-discard-action.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-fragment-sign.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-fragment-unsign.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-perform-action-error.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-add-board-member.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-add-proposer.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-change-quorum.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-remove-user.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-sc-call.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-sc-deploy.k"  //@ Bazel remove
require "run-external-call-from-user/trusted-recfu-propose-send-egld.k"  //@ Bazel remove

require "../../lemmas/0/list/no-map-key-in-list/trusted-no-map-key-in-list-list-to-map-set.k"  //@ Bazel remove

module PROOF-RUN-EXTERNAL-CALL-FROM-USER
  imports TRUSTED-NO-MAP-KEY-IN-LIST-LIST-TO-MAP-SET
  imports TRUSTED-RECFU-FRAGMENT-DISCARD-ACTION
  imports TRUSTED-RECFU-FRAGMENT-SIGN
  imports TRUSTED-RECFU-FRAGMENT-UNSIGN
  imports TRUSTED-RECFU-PERFORM-ACTION-ERROR
  imports TRUSTED-RECFU-PROPOSE-ADD-BOARD-MEMBER
  imports TRUSTED-RECFU-PROPOSE-ADD-PROPOSER
  imports TRUSTED-RECFU-PROPOSE-CHANGE-QUORUM
  imports TRUSTED-RECFU-PROPOSE-REMOVE-USER
  imports TRUSTED-RECFU-PROPOSE-SC-CALL
  imports TRUSTED-RECFU-PROPOSE-SC-DEPLOY
  imports TRUSTED-RECFU-PROPOSE-SEND-EGLD

//@ trusted
// module TRUSTED-RUN-EXTERNAL-CALL-FROM-USER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> runExternalCallFromUser(
                  MaliciousAddress:Address,
                  DeleteActionId:Usize,
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
              ( DeleteActionId |-> RemoveUser(MaliciousAddress)
                _OldActionData:Map
              ) #as OldActionData:Map,
              ( DeleteActionId |-> [DeleteFirstSignerId:Usize, _Signers:ExpressionCSV] #as Signers:ExpressionList
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
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(?NewActionLastIndex:Int),
              DeleteActionId |-> RemoveUser(MaliciousAddress) ?NewActionData:Map,
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

        andBool noMapKeyInList(UnprocessedUserRoles[MaliciousId <- undef], Signers)

        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(OldActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool allKeysBecomeKeys(OldActionSigners, OldActionData)

        andBool notBool u(0) in_keys(UserIdToRole)
        andBool Quorum >Int 1
        andBool DeleteFirstSignerId =/=K MaliciousId

    ensures true
        andBool noQuorumCanBeFilledBy(
            Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
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

        andBool noMapKeyInList(
                    UnprocessedUserRoles[MaliciousId <- undef],
                    [DeleteFirstSignerId:Usize, ?NewSigners]
                )

        andBool allKeysBecomeKeys(
                    DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners] ?NewActionSigners,
                    DeleteActionId |-> RemoveUser(MaliciousAddress) ?NewActionData
                )

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
