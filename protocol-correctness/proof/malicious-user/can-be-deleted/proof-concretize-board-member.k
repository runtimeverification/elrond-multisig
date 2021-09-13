// breadth = 4
//@ proof
// Not working because of https://github.com/kframework/kore/issues/2828
require "../../functions/trusted-propose-action-BoardMember.k"  //@ Bazel remove
require "../../map/trusted-map-semantics.k"  //@ Bazel remove

module PROOF-CONCRETIZE-BOARD-MEMBER
  imports TRUSTED-MAP-SEMANTICS
//@ trusted
// module TRUSTED-CONCRETIZE-BOARD-MEMBER
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-DELETE-ACTIONS

  claim <T><TT>
          <k> withPickedUserMakeConcretePrefix(AddressToUserId, UserIdToAddress, MaliciousAddress, UserId)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> MaliciousRole:UserRole UserId |-> BoardMember _UserIdToRole:Map) #as UserIdToRole:Map,
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
              (MaliciousId |-> MaliciousAddress UserId |-> ?UserAddress:Address ?UserIdToAddress:Map),
              (MaliciousAddress |-> MaliciousId:Usize ?UserAddress |-> ?SomeId ?AddressToUserId:Map),
              //AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex),
              ActionData,
              ActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool notBool (UserIdToAddress[UserId] orDefault void ==K MaliciousAddress)
        // andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember)) >Int #if MaliciousRole ==K BoardMember #then 1 #else 0 #fi
        // andBool notBool MaliciousRole ==K None
        andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)
        andBool userIdToAddressInvariant(UserIdToAddress)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool allValuesBecomeKeys(UserIdToAddress, AddressToUserId)
        // andBool mapsAreReverseHalf(AddressToUserId, UserIdToAddress)

        // andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        // andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))
        // andBool valuesAreOfType(UserIdToRole, rUserRole)
        // andBool valuesAreKResult(UserIdToRole)
    ensures true
        //andBool ?UserIdToAddress1 ==K UserIdToAddress
        andBool UserIdToAddress ==K (MaliciousId |-> MaliciousAddress UserId |-> ?UserAddress:Address ?UserIdToAddress:Map)
        andBool AddressToUserId ==K (MaliciousAddress |-> MaliciousId ?UserAddress |-> ?SomeId ?AddressToUserId:Map)
            // #if MaliciousAddress ==K ?UserAddress
            // #then
            //   (?UserAddress |-> MaliciousId ?AddressToUserId:Map)
            // #else
            //   (MaliciousAddress |-> MaliciousId ?UserAddress |-> UserId ?AddressToUserId:Map)
            // #fi
    //@ proof
    //@ trusted
    // [trusted]
    //@ end


  claim <T><TT>
          <k> withPickedUserMakeConcretePrefix(AddressToUserId, UserIdToAddress, MaliciousAddress, UserId)
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              (MaliciousId |-> MaliciousAddress _UserIdToAddress:Map) #as UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> MaliciousRole:UserRole UserId |-> BoardMember _UserIdToRole:Map) #as UserIdToRole:Map,
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
              (MaliciousId |-> MaliciousAddress UserId |-> MaliciousAddress ?UserIdToAddress:Map),
              AddressToUserId,
              //AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex),
              ActionData,
              ActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool (UserIdToAddress[UserId] orDefault void ==K MaliciousAddress)
        // andBool mapCount(UserIdToRole, MEP.IsValue(BoardMember)) >Int #if MaliciousRole ==K BoardMember #then 1 #else 0 #fi
        // andBool notBool MaliciousRole ==K None
        andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)
        andBool userIdToAddressInvariant(UserIdToAddress)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool allValuesBecomeKeys(UserIdToAddress, AddressToUserId)
        // andBool mapsAreReverseHalf(AddressToUserId, UserIdToAddress)

        // andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionData), expand(expanded))
        // andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionSigners), expand(expanded))
        // andBool valuesAreOfType(UserIdToRole, rUserRole)
        // andBool valuesAreKResult(UserIdToRole)
    ensures true
        //andBool ?UserIdToAddress1 ==K UserIdToAddress
        andBool UserIdToAddress ==K (MaliciousId |-> MaliciousAddress UserId |-> MaliciousAddress:Address ?UserIdToAddress:Map)
            // #if MaliciousAddress ==K ?UserAddress
            // #then
            //   (?UserAddress |-> MaliciousId ?AddressToUserId:Map)
            // #else
            //   (MaliciousAddress |-> MaliciousId ?UserAddress |-> UserId ?AddressToUserId:Map)
            // #fi
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
