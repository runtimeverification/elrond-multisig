// timeout = long
// breadth = 6
//@ proof
require "../../functions/trusted-propose-action-BoardMember.k"  //@ Bazel remove
require "../../map/trusted-map-semantics.k"  //@ Bazel remove
require "trusted-concretize-board-member.k"  //@ Bazel remove

module PROOF-PROPOSE-DELETE-MALICIOUS
  imports TRUSTED-PROPOSE-ACTION-BOARDMEMBER
  imports TRUSTED-MAP-SEMANTICS
  imports TRUSTED-CONCRETIZE-BOARD-MEMBER
//@ trusted
// module TRUSTED-PROPOSE-DELETE-MALICIOUS
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
              ~> withPickedUserCall(proposeRemoveUser(MaliciousAddress))
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> MaliciousRole:UserRole _UserIdToRole:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(ActionLastIndex:Int),
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex +Int 1),
              u(ActionLastIndex +Int 1) |-> RemoveUser(MaliciousAddress) ActionData,
              (u(ActionLastIndex +Int 1) |-> [?SomeId:Usize, .]) ActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember)) >Int #if MaliciousRole ==K BoardMember #then 1 #else 0 #fi
        andBool notBool MaliciousRole ==K None
        andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)
        andBool userIdToAddressInvariant(UserIdToAddress)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool mapsAreReverse(UserIdToAddress, AddressToUserId)

        andBool mapKeysAreBelowLimit(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        andBool mapKeysAreBelowLimit(ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))
        andBool mapValuesAreOfType(UserIdToRole, rUserRole)
        andBool mapValuesAreKResult(UserIdToRole)
        // andBool maliciousDeleteInvariant(
        //     MaliciousAddress,
        //     NumUsers,
        //     UserIdToAddress,
        //     AddressToUserId,
        //     NumBoardMembers,
        //     NumProposers,
        //     UserIdToRole,
        //     u(Quorum),
        //     u(ActionLastIndex),
        //     ActionData,
        //     ActionSigners,
        //     expand(expanded))
    ensures true
        // andBool maliciousDeleteInvariant(
        //     MaliciousAddress,
        //     NumUsers,
        //     UserIdToAddress,
        //     AddressToUserId,
        //     NumBoardMembers,
        //     NumProposers,
        //     UserIdToRole,
        //     u(Quorum),
        //     u(ActionLastIndex +Int 1),
        //     u(ActionLastIndex +Int 1) |-> RemoveUser(MaliciousAddress) ActionData,
        //     ActionSigners,
        //     usesExpanded)
        andBool notBool ?SomeId ==K MaliciousId
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
