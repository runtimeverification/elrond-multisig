// timeout = moderate
// breadth = 1
//@ proof

require "../../lemmas/0/map/trusted-map-keys-are-below-limit-ignore-property-handling.k"  //@ Bazel remove

module PROOF-CALL-INVARIANT-SUFFIX-FRAGMENT
  imports TRUSTED-MAP-KEYS-ARE-BELOW-LIMIT-IGNORE-PROPERTY-HANDLING

//@ trusted
// module TRUSTED-CALL-INVARIANT-SUFFIX-FRAGMENT
//@ end

  imports BASE-TYPES-SYNTAX
  imports CONCRETIZE-VALUE-SYNTAX
  imports INVARIANT
  imports K-EQUAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports MAP
  imports PSEUDOCODE-CONFIGURATION
  imports RUNNING-SYNTAX

  claim <T><TT>
          <k> deleteMaliciousUserActionId(DeleteActionId)
              ~> actionDataKeysAreBelowLimitConvertExpanded
              ~> actionSignersKeysAreBelowLimitConvertExpanded
              ~> concretizeDeleteActionSigners(DeleteActionId)
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
              u(ActionLastIndex:Int),
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> concretizeDeleteActionSigners(DeleteActionId)
              ~> K:K
          </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              Quorum,
              u(ActionLastIndex),
              ActionData,
              ActionSigners,
              PerformedActions):StateCell
        </TT></T>
    requires true
        andBool mapKeysAreOfType(ActionData, rUsize)
        andBool mapKeysAreOfType(ActionSigners, rUsize)
    ensures true
        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1, keysMap(ActionData), usesExpanded)
                ==K mapKeysAreBelowLimitSafe(
                        ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(
                    ActionLastIndex +Int 1, keysMap(ActionSigners), usesExpanded)
                ==K mapKeysAreBelowLimitSafe(
                        ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))

    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
