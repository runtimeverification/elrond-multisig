// timeout = eternal
// breadth = 32
//@ proof
require "trusted-call-invariant-prefix-fragment-sign.k"  //@ Bazel remove
require "trusted-call-invariant-suffix-fragment.k"  //@ Bazel remove
require "trusted-sign.k"  //@ Bazel remove
require "../../fragments/trusted-make-concrete-value-fragment.k"  //@ Bazel remove

module PROOF-CALL-INVARIANT-FRAGMENT-SIGN
    imports TRUSTED-SIGN
    imports TRUSTED-CALL-INVARIANT-PREFIX-FRAGMENT-SIGN
    imports TRUSTED-CALL-INVARIANT-SUFFIX-FRAGMENT
    imports TRUSTED-MAKE-CONCRETE-VALUE-FRAGMENT

//@ trusted
// module TRUSTED-CALL-INVARIANT-FRAGMENT-SIGN
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> 
              branchK(
                  MaliciousAddress:Address in_keys (AddressToUserId:Map),
                  makeConcreteValue(
                      MaliciousAddress,
                      rUsize,
                      AddressToUserId:Map
                    )
                    ~> branchK(
                          (AddressToUserId:Map[MaliciousAddress] orDefault void)
                              in_keys(UserIdToRole:Map),
                          makeConcreteValue(
                              AddressToUserId:Map[MaliciousAddress] orDefault void,
                              rUserRole,
                              UserIdToRole:Map
                          ),
                          .K
                      ),
                  .K
                  )
              ~> concretizeValue(ActionId:Usize)
              ~> concretizeValue(ActionId in_keys(ActionData:Map))
              ~> concretizeValue(ActionId ==K DeleteActionId:Usize)
              ~> runExternalCall(
                    from MaliciousAddress run sign(ActionId);
                )
              ~> deleteMaliciousUserActionId(DeleteActionId)
              // ~> callLemmaNoMapKeyInListListToMapSet
              //     ( DeleteActionId
              //     , AddressToUserId:Map[MaliciousAddress] orDefault void
              //     , UnprocessedUserRoles
              //     , DeleteSigners:KItem
              //     )
              ~> actionDataKeysAreBelowLimitConvertExpanded
              ~> actionSignersKeysAreBelowLimitConvertExpanded
              ~> concretizeDeleteActionSigners(DeleteActionId)
              ~> passSigners
              ~> runExternalCallsFromUser(
                    MaliciousAddress,
                    DeleteActionId,
                    Count:Int,
                    UnprocessedUserRoles:Map,
                    LemmasForCannotExecuteProof
                )
              ~> callLemmaOnlyThisSignerDiffsTransitiveFreezer(
                    MaliciousId:Usize,
                    ActionSigners:Map
                )
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserIdToRole:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCallsFromUser(
                  MaliciousAddress:Address, DeleteActionId:Usize, Count:Int,
                  UnprocessedUserRoles,
                  LemmasForCannotExecuteProof)
              ~> callLemmaOnlyThisSignerDiffsTransitive(
                    MaliciousId,
                    ActionSigners,
                    ?ActionSigners
                )
              ~> K:K
          </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(?ActionLastIndex:Int),
              ?ActionData:Map,
              ?ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expanded))
    ensures true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            u(?ActionLastIndex),
            ?ActionData,
            ?ActionSigners,
            //@ proof
            usesExpanded
            //@ trusted
            // expand(expanded)
            //@ end
            )
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
