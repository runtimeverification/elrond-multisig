// timeout = long
// breadth = 6
//@ proof
require "../../functions/trusted-perform-action-endpoint-remove-user-BoardMember-marker.k"  //@ Bazel remove
require "../../functions/trusted-perform-action-endpoint-remove-user-Proposer-marker.k"  //@ Bazel remove
require "../../map/trusted-map-semantics.k"  //@ Bazel remove
require "trusted-concretize-board-member.k"  //@ Bazel remove

module PROOF-EXECUTE-DELETE-MALICIOUS
  imports TRUSTED-MAP-SEMANTICS
  imports TRUSTED-CONCRETIZE-BOARD-MEMBER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-REMOVE-USER-BOARDMEMBER-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-REMOVE-USER-PROPOSER-MARKER
//@ trusted
// module TRUSTED-EXECUTE-DELETE-MALICIOUS
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MAP-EXECUTE-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MAPS-ARE-REVERSE-SYNTAX
  imports PSEUDOCODE-CONFIGURATION

  claim <T><TT>
          <k> pickOtherBoardMember(UserIdToRole, AddressToUserId, UserIdToAddress, MaliciousAddress:Address)
              ~> withPickedUserCall(performActionEndpoint(ActionIndex:Usize))
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              (MaliciousId |-> MaliciousRole:UserRole FinalUserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ( ActionIndex |-> RemoveUser(MaliciousAddress) FinalActionData:Map ),
              ( ActionIndex |-> Signers:ExpressionList FinalActionSigners:Map
              ) #as ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              u(NumBoardMembers -Int #if MaliciousRole ==K BoardMember #then 1 #else 0 #fi),
              u(NumProposers -Int #if MaliciousRole ==K Proposer #then 1 #else 0 #fi),
              FinalUserIdToRole,
              u(Quorum),
              ActionLastIndex,
              FinalActionData,
              FinalActionSigners,
              ListItem(RemoveUser(MaliciousAddress)) PerformedActions:List
          ):StateCell
        </TT></T>
    requires true
        andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember)) >Int #if MaliciousRole ==K BoardMember #then 1 #else 0 #fi
        andBool notBool MaliciousRole ==K None
        andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)
        andBool userIdToAddressInvariant(UserIdToAddress)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool mapsAreReverse(UserIdToAddress, AddressToUserId)
        andBool actionSignersInvariant(ActionSigners)
        andBool Quorum
                <=Int NumBoardMembers -Int boolToInt(MaliciousRole ==K BoardMember)

        andBool userIdToRoleInvariant(UserIdToRole)
        andBool Quorum <=Int countCanSignFunction(Signers, UserIdToRole)
        andBool NumBoardMembers ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))
        andBool NumProposers ==Int mapCount(UserIdToRole, MEP.IsValue(Proposer))
        // andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        // andBool mapKeysAreBelowLimitSafe(ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))
        // andBool mapKeysAreOfType(ActionData, rUsize)
        // andBool mapKeysAreOfType(ActionSigners, rUsize)
        // andBool mapValuesAreOfType(UserIdToRole, rUserRole)
        // andBool mapValuesAreKResult(UserIdToRole)
    ensures true
        // andBool notBool ?SomeId ==K MaliciousId
        // andBool ?SomeId in_keys(UserIdToRole)
        // andBool UserIdToRole[?SomeId] ==K BoardMember
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
