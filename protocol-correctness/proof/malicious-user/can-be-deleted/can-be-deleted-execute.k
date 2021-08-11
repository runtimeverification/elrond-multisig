require "protocol-correctness/proof/main-proof-execute.k"
require "protocol-correctness/proof/invariant/invariant-execute.k"
require "protocol-correctness/proof/malicious-user/malicious-user-execute.k"
require "protocol-correctness/proof/properties/properties-execute.k"

module CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-SYNTAX
  imports MALICIOUS-USER-DELETE-ACTIONS-SYNTAX
  imports MALICIOUS-USER-DELETE-INVARIANT-SYNTAX
endmodule

module MALICIOUS-USER-DELETE-ACTIONS-SYNTAX
  imports MAP
  imports PSEUDOCODE-SYNTAX

  imports PROPERTIES-EXECUTE

  syntax KItem ::= allBoardMembersSignForInterspersed(/*actionId:*/Usize, K)
  syntax KItem ::= boardMembersSignForInterspersed(/*actionId:*/Usize, /*userRoles:*/Map, K)
  syntax KItem ::= boardMembersSignForInterspersedFreezer(/*actionId:*/Usize, K)
  syntax KItem ::= #boardMembersSignForInterspersed(
                      /*actionId:*/Usize,
                      /*key:*/KItem,
                      /*value:*/KItem,
                      /*userRoles:*/Map,
                      K)
  syntax KItem ::= pickOtherBoardMember(
                      /*userIdToRole:*/Map,
                      /*addressToUserId:*/Map,
                      /*userIdToAddress:*/Map,
                      Address)
endmodule

module MALICIOUS-USER-DELETE-ACTIONS
  imports MALICIOUS-USER-DELETE-ACTIONS-SYNTAX

  rule  <k> allBoardMembersSignForInterspersed(ActionId:Usize, K:K)
            => boardMembersSignForInterspersed(ActionId, UserIdToRole, K)
        ...</k>
        <user-roles> UserIdToRole:Map </user-roles>
        <action-signers> ActionSigners:Map </action-signers>
    requires notBool (ActionId in_keys(ActionSigners))

  rule  <k> allBoardMembersSignForInterspersed(ActionId:Usize, K:K)
            => boardMembersSignForInterspersed(ActionId, UserIdToRole, K)
        ...</k>
        <user-roles> UserId |-> BoardMember UserIdToRole:Map </user-roles>
        <action-signers> ActionId |-> [UserId:Usize, .] _ActionSigners:Map </action-signers>

  rule  boardMembersSignForInterspersed(_ActionId:Usize, .Map, _:K) => .K
  rule  boardMembersSignForInterspersed(ActionId:Usize, UserIdToRole:Map, K:K)
        =>  (  lazyMapSelectProperty(UserIdToRole, MEP.AlwaysTrue)
            ~> boardMembersSignForInterspersedFreezer(ActionId, K)
            )
    requires notBool (UserIdToRole ==K .Map)

  rule  (  mapSelected(Key:KItem, Value:KItem, UserIdToRole:Map)
        ~> boardMembersSignForInterspersedFreezer(ActionId:Usize, K:K)
        )
        => #boardMembersSignForInterspersed(ActionId, Key, Value, UserIdToRole, K)

  rule  #boardMembersSignForInterspersed(
            ActionId:Usize,
            UserId:KItem,
            V:KItem,
            UserIdToRole:Map,
            K:K)
        =>  (   cast(V, rUserRole)
            ~>  removeValue
            ~>  concretizeValue(V)
            ~>  branchK(
                  V ==K BoardMember,
                  cast(UserId, rUsize)
                    ~> removeValue
                    ~> signFor(ActionId, UserId)
                    ~> K
                    ~> boardMembersSignFor(ActionId, UserIdToRole),
                  boardMembersSignFor(ActionId, UserIdToRole)
                )
            )

  rule pickOtherBoardMember(UserIdToRole:Map, AddressToUserId:Map, UserIdToAddress:Map, Address:Address)
      =>  makeConcreteValue(Address, rUsize, AddressToUserId)
          ~> makeConcreteValue(AddressToUserId[Address], rAddress, UserIdToAddress)
          ~> makeConcreteValue(AddressToUserId[Address], rUserRole, UserIdToRole)
          ~> #pickOtherBoardMember(UserIdToRole, AddressToUserId[Address])
          ~> withPickedUserMakeConcrete(AddressToUserId, UserIdToAddress, Address)
    requires Address in_keys(AddressToUserId)
  rule pickOtherBoardMember(UserIdToRole:Map, AddressToUserId:Map, _UserIdToAddress:Map, Address:Address)
      => pickBoardMember(UserIdToRole)
    requires notBool Address in_keys(AddressToUserId)

  syntax KItem ::= #pickOtherBoardMember(
                      /*userIdToRole:*/Map,
                      /*userId:*/KItem)
  rule #pickOtherBoardMember(UserIdToRole:Map, UserId:KItem)
    => pickBoardMember(UserIdToRole[UserId <- undef])
    requires UserId in_keys(UserIdToRole)
  rule #pickOtherBoardMember(UserIdToRole:Map, UserId:KItem)
    => pickBoardMember(UserIdToRole)
    requires notBool UserId in_keys(UserIdToRole)

  syntax KItem ::= withPickedUserMakeConcrete(addressToUserId:Map, userIdToAddress:Map, maliciousAddress:Address)
  rule  (  mapSelected(UserId:KItem, _UserRole:KItem, _Remainder:Map) #as Selected:KItem
        ~> withPickedUserMakeConcrete(AddressToUserId:Map, UserIdToAddress:Map, MaliciousAddress:Address)
        )
      =>
        (  withPickedUserMakeConcretePrefix(AddressToUserId, UserIdToAddress, MaliciousAddress, UserId)
        ~> makeConcreteValue(UserId, rAddress, UserIdToAddress)
        ~> Selected
        )
    requires true
      andBool UserId in_keys(UserIdToAddress)

  syntax KItem ::= withPickedUserMakeConcretePrefix(addressToUserId:Map, userIdToAddress:Map, maliciousAddress:Address, userId:KItem)
  rule withPickedUserMakeConcretePrefix(AddressToUserId:Map, UserIdToAddress:Map, MaliciousAddress:Address, UserId:KItem)
      =>
        (  concretizeMapKey(UserId, UserIdToAddress)
        ~> cast(UserIdToAddress[UserId], rAddress)
        ~> removeValue
        ~> concretizeValue(UserIdToAddress[UserId] ==K MaliciousAddress)
        ~> concretizeValue(UserIdToAddress[UserId])
        ~> makeConcreteValue(UserIdToAddress[UserId], rUsize, AddressToUserId)
        ~> concretizeMapKey(UserIdToAddress[UserId], AddressToUserId)
        )

endmodule

module MALICIOUS-USER-DELETE-INVARIANT-SYNTAX
  imports MAP
  imports PSEUDOCODE-SYNTAX
  imports EXECUTION-PROOF-HELPERS

  syntax Bool ::= maliciousDeleteInvariant(
            /*maliciousAddress:*/Address,
            /*numUsers:*/Usize,
            /*currentUserIdToAddress:*/Map,
            /*currentAddressToUserId:*/Map,
            /*numBoardMembers:*/Usize,
            /*numProposers:*/Usize,
            /*userRoles:*/Map,
            /*quorum:*/Usize,
            /*actionLastIndex:*/Usize,
            /*actionData:*/Map,
            /*actionSigners:*/Map,
            PropertyHandling)
      [function, functional]
endmodule

module MALICIOUS-USER-DELETE-INVARIANT
  imports MALICIOUS-USER-DELETE-INVARIANT-SYNTAX

  imports INVARIANT
  imports MALICIOUS-USER-INVARIANT-FUNCTIONS

  rule  maliciousDeleteInvariant(
            MaliciousAddress:Address,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserIdToRole:Map,
            u(Quorum:Int),
            ActionLastIndex:Usize,
            ActionData:Map,
            ActionSigners:Map,
            Handling:PropertyHandling)
      => true
        andBool baseInvariant(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ActionSigners,
            Handling)
        andBool onlyThisSigner(AddressToUserId, MaliciousAddress, ActionSigners)
        andBool Quorum >=Int 2
        andBool mapCount(UserIdToRole[AddressToUserId[MaliciousAddress] orDefault u(0) <- undef], MEP.IsValue(BoardMember)) >Int 0

endmodule

module CAN-BE-DELETED-EXECUTE
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MALICIOUS-USER-DELETE-INVARIANT
  imports MALICIOUS-USER-DELETE-ACTIONS
  imports MALICIOUS-USER-HELPERS
  imports MAIN-PROOF-EXECUTE

  // TODO: Not sure why the Haskell backend does not evaluate this.
  // Remove when it does.
  rule address(A1) ==K address(A2) => A1 ==K A2
endmodule
