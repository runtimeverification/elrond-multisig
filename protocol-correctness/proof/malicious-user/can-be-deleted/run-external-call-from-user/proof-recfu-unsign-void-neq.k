// timeout = eternal
// breadth = 16
//@ proof

require "../../../functions/trusted-unsign-no-signers.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-not-signed.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-only-signer.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-other-signers-first.k"  //@ Bazel remove
require "../../../functions/trusted-unsign-other-signers-not-first.k"  //@ Bazel remove
require "../../../lemmas/0/int/trusted-lemma-add-one-if-not-negative.k"  //@ Bazel remove
require "../../../lemmas/0/list/plistlen/trusted-lemma-plistlen.k"  //@ Bazel remove
require "../../../lemmas/0/map/square-bracket/trusted-lemma-square-bracket-square-bracket-undef.k"  //@ Bazel remove
require "../../../lemmas/0/signers/trusted-lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys.k"  //@ Bazel remove
require "../../../lemmas/0/signers/trusted-lemma-count-can-sign-function-element-last-to-start.k"  //@ Bazel remove
require "../../../lemmas/0/signers/trusted-lemma-count-can-sign-function-last-remove-last.k"  //@ Bazel remove
require "../../../lemmas/0/signers/trusted-lemma-count-can-sign-function-second-element.k"  //@ Bazel remove
require "../../../lemmas/0/signers/trusted-lemma-count-can-sign-map.k"  //@ Bazel remove
require "../../../lemmas/1/list/contains/trusted-lemma-list-contains-last-to-start.k"  //@ Bazel remove
require "../../../lemmas/1/list/contains/trusted-lemma-list-contains-list-find.k"  //@ Bazel remove
require "../../../lemmas/1/list/last/trusted-lemma-last-to-start-kresult.k"  //@ Bazel remove
require "../../../lemmas/1/list/last/trusted-lemma-last-to-start-usize.k"  //@ Bazel remove
require "../../../lemmas/1/list/last/trusted-lemma-pound-last.k"  //@ Bazel remove
require "../../../lemmas/1/list/last/trusted-lemma-pound-last-usize-kitem.k"  //@ Bazel remove
require "../../../lemmas/1/list/last/trusted-lemma-pound-remove-last-kresult-expression.k"  //@ Bazel remove
require "../../../lemmas/1/list/last/trusted-lemma-pound-remove-last-usize.k"  //@ Bazel remove
require "../../../lemmas/1/list/list-to-map-set/trusted-lemma-list-to-map-set-pound-remove-last-pound-last.k"  //@ Bazel remove
require "../../../lemmas/1/map/square-bracket/trusted-lemma-square-bracket-sq-b-sq-b-undef.k"  //@ Bazel remove
require "../../../lemmas/2/list/contains/trusted-lemma-list-contains-pound-list-swap-remove-2.k"  //@ Bazel remove
require "../../../lemmas/2/list/contains/trusted-lemma-list-contains-pound-remove-last-pound-last.k"  //@ Bazel remove
require "../../../lemmas/2/list/contains/trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-eq.k"  //@ Bazel remove
require "../../../lemmas/2/list/contains/trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-neq.k"  //@ Bazel remove
require "../../../lemmas/2/list/list-to-map-set/trusted-lemma-list-to-map-set-last-to-start.k"  //@ Bazel remove
require "../../../lemmas/4/list/contains/trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq.k"  //@ Bazel remove
require "../../../lemmas/4/list/list-to-map-set/trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete.k"  //@ Bazel remove

module PROOF-RECFU-UNSIGN-VOID-NEQ
  imports TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-2-ELEMENTS-SWAP-REMOVE-FIND-UNSAFE-NOT-IN-KEYS
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-ELEMENT-LAST-TO-START
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-LAST-REMOVE-LAST
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-SECOND-ELEMENT
  imports TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
  imports TRUSTED-LEMMA-LAST-TO-START-KRESULT
  imports TRUSTED-LEMMA-LAST-TO-START-USIZE
  imports TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-CONTAINS-LIST-FIND
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST-POUND-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-2-ELEMENT-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-EQ
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports TRUSTED-LEMMA-LIST-TO-MAP-SET-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-TO-MAP-SET-POUND-REMOVE-LAST-POUND-LAST
  imports TRUSTED-LEMMA-PLISTLEN
  imports TRUSTED-LEMMA-POUND-LAST
  imports TRUSTED-LEMMA-POUND-LAST-USIZE-KITEM
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-KRESULT-EXPRESSION
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-USIZE
  imports TRUSTED-LEMMA-SQUARE-BRACKET-SQ-B-SQ-B-UNDEF
  imports TRUSTED-LEMMA-SQUARE-BRACKET-SQUARE-BRACKET-UNDEF
  imports TRUSTED-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-SQ-B-SQ-B-SQ-B-DELETE
  imports TRUSTED-UNSIGN-NO-SIGNERS
  imports TRUSTED-UNSIGN-NOT-SIGNED
  imports TRUSTED-UNSIGN-ONLY-SIGNER
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-FIRST
  imports TRUSTED-UNSIGN-OTHER-SIGNERS-NOT-FIRST
//@ trusted
// module TRUSTED-RECFU-UNSIGN-VOID-NEQ
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MALICIOUS-USER-INVARIANT
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  claim <T><TT>
          <k> pushContext ~> preCall
              ~> call(unsign(UnsignActionId:Usize))
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
              ( MaliciousId |-> MaliciousRole:UserRole
                DeleteFirstSignerId |-> BoardMember
                _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(ActionLastIndex:Int),
              ActionData:Map,
              ( DeleteActionId |-> [DeleteFirstSignerId:Usize, _Signers:ExpressionCSV]
                _OldActionSigners
              ) #as OldActionSigners:Map,
              address(MaliciousAddress:Int),
              Stack:Stack,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(void)
              ~> clearExternalCallEnv
              ~> deleteMaliciousUserActionId(DeleteActionId:Usize)
              ~> K
          </k>
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
              DeleteActionId |-> [DeleteFirstSignerId:Usize, ?NewSigners:ExpressionCSV]
                ?NewActionSigners:Map,
              address(MaliciousAddress),
              Stack:Stack,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool UnsignActionId ==K DeleteActionId
        andBool UnsignActionId in_keys ( ActionData )
        andBool MaliciousRole ==K BoardMember

        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, OldActionSigners[DeleteActionId <- undef], UserIdToRole)
        andBool actionDataInvariant(ActionData)
        andBool valueIsNotEmpty(MaliciousRole, rUserRole)
        andBool actionSignersInvariant(OldActionSigners)

        andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(OldActionSigners), expand(expanded))

        andBool allKeysBecomeKeys(OldActionSigners, ActionData)

        andBool userIdToRoleInvariant(UserIdToRole)

    ensures true
        andBool noQuorumCanBeFilledBy(Quorum, MaliciousId, ?NewActionSigners, UserIdToRole)
        andBool actionSignersInvariant(
                    DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners]
                      ?NewActionSigners
                )

        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1,
                    keysMap(
                        DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners]
                          ?NewActionSigners
                    ),
                    usesExpanded)

        andBool onlyThisSignerDiffs(
                    MaliciousId,
                    OldActionSigners,
                    DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners]
                      ?NewActionSigners,
                    UserIdToRole)

        andBool allKeysBecomeKeys(
                    DeleteActionId |-> [DeleteFirstSignerId, ?NewSigners] ?NewActionSigners,
                    ActionData)

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
