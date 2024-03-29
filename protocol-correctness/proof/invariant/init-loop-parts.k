require "protocol-correctness/lib/functions/can-add-list-elements-at-index.k"
require "protocol-correctness/lib/functions/can-add-value-for-list-elements-at-index.k"
require "protocol-correctness/lib/functions/list-elements-are-of-type.k"
require "protocol-correctness/lib/functions/map-keys-are-below-limit.k"
require "protocol-correctness/lib/functions/maps-are-reverse.k"
require "protocol-correctness/pseudocode.k"
require "protocol-correctness/proof/execution-proof-helpers.k"
require "protocol-correctness/proof/invariant.k"
require "protocol-correctness/proof/map/map-execute.k"

module INIT-LOOP-PARTS
  imports PSEUDOCODE
  imports INVARIANT-HELPERS
  imports CAN-ADD-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports CAN-ADD-VALUE-FOR-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports LIST-ELEMENTS-ARE-OF-TYPE-SYNTAX
  imports MAP-EXECUTE-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-ARE-BELOW-LIMIT-SYNTAX
  imports MAPS-ARE-REVERSE-SYNTAX

  syntax TTCell ::= initLoopLhs(
            /*prevIndex:*/Usize,
            /*addresses:*/ExpressionList,
            K,
            /*userIdToAddress:*/Map,
            /*addressToUserId:*/Map,
            /*userIdToRole:*/Map,
            /*quorum:*/Usize,
            ActionStateCell,
            /*variables:*/Map,
            /*stack:*/Stack,
            ExternalCallEnvCell,
            /*address:*/Expression,
            /*userId:*/Usize)
      [function, functional]
  rule initLoopLhs(
            PrevIndex:Usize,
            Addresses:ExpressionList,
            K:K,
            UserIdToAddress0:Map,
            AddressToUserId0:Map,
            UserIdToRole0:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Variables:Map,
            Stack:Stack,
            ExternalCallEnv:ExternalCallEnvCell,
            Address:Expression,
            UserId:Usize)
      => <TT>
          <k>
            runInstruction(
                for (i = add(PrevIndex, u(1)), address ) in Addresses {
                    user_id = i + u(1);
                    require(getUserId(address) == u(0));
                    setUserId(address, user_id);
                    setUserAddress(user_id, address);
                    setUserIdToRole(user_id, BoardMember);
                }
            )
            ~> K
          </k>
          <state>
            <contract-state>
              <users>
                <num-users>u(0)</num-users>
                <user-id-to-address>UserIdToAddress0</user-id-to-address>
                <address-to-user-id>AddressToUserId0</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(0)</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole0</user-roles>
                <quorum>Quorum</quorum>
              </board-state>
              ActionState
            </contract-state>
            <pseudocode-state>
              <variables>
                i |-> PrevIndex
                address |-> Address
                user_id |-> UserId
                Variables
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
            ExternalCallEnv
            <log>
              <performed-actions>.List</performed-actions>
            </log>
          </state>
        </TT>

  syntax TTCell ::= initLoopRhs(
            KItem,
            K,
            /*userIdToAddress:*/Map,
            /*addressToUserId:*/Map,
            /*userIdToRole:*/Map,
            /*quorum:*/Usize,
            ActionStateCell,
            /*variables:*/Map,
            /*stack:*/Stack,
            ExternalCallEnvCell,
            /*index:*/Usize,
            /*address:*/Expression,
            /*userId:*/Usize)
      [function, functional]
  rule initLoopRhs(
            Item:KItem,
            K:K,
            UserIdToAddress1:Map,
            AddressToUserId1:Map,
            UserIdToRole1:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Variables:Map,
            Stack:Stack,
            ExternalCallEnv:ExternalCallEnvCell,
            Index:Usize,
            Address:Expression,
            UserId:Usize)
      =>
        <TT>
          <k> Item ~> K </k>
          <state>
            <contract-state>
              <users>
                <num-users>u(0)</num-users>
                <user-id-to-address>UserIdToAddress1</user-id-to-address>
                <address-to-user-id>AddressToUserId1:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(0)</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole1</user-roles>
                <quorum>Quorum</quorum>
              </board-state>
              ActionState
            </contract-state>
            <pseudocode-state>
              <variables>
                (i |-> Index)
                (address |-> Address)
                (user_id |-> UserId)
                Variables
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
            ExternalCallEnv
            <log>
              <performed-actions>.List</performed-actions>
            </log>
          </state>
        </TT>

  syntax Bool ::= initLoopRequires(
            prevIndex:Usize,
            addresses:ExpressionList,
            userIdToAddress:Map,
            addressToUserId:Map,
            userIdToRole:Map)
      [function, functional]
  rule initLoopRequires(
            u(PrevIndex:Int),
            Addresses:ExpressionList,
            UserIdToAddress0:Map,
            AddressToUserId0:Map,
            UserIdToRole0:Map)
      => true
            andBool PrevIndex >=Int 0
            andBool isKResult(Addresses)

            andBool canAddListElementsAtIndex(add(u(PrevIndex), u(2)), UserIdToAddress0, Addresses)
            andBool canAddValueForListElementsAtIndex(
                        add(u(PrevIndex), u(2)), UserIdToRole0, Addresses, BoardMember)
            andBool listElementsAreOfType(Addresses, rAddress)

            andBool initLoopInvariant(
                        add(u(PrevIndex), u(1)),
                        UserIdToAddress0,
                        AddressToUserId0,
                        UserIdToRole0,
                        expand(expanded))

  syntax Bool ::= initLoopEnsures(
      numUsers:Usize,
      addresses:ExpressionList,
      userIdToAddress:Map,
      addressToUserId:Map,
      userIdToRole0:Map,
      userIdToRole:Map)  [function, functional]

  rule initLoopEnsures(
      NumUsers:Usize,
      Addresses:ExpressionList,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      UserIdToRole0:Map,
      UserIdToRole:Map)
    => true
      andBool initLoopInvariant(
                  NumUsers,
                  UserIdToAddress,
                  AddressToUserId,
                  UserIdToRole,
                  usesExpanded)
      andBool pListLen(Addresses)
                  +Int mapCount(UserIdToRole0, MEP.IsValue(BoardMember))
              ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))

  syntax Bool ::= initLoopInvariant(
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      userIdToRole:Map,
      handling:PropertyHandling)  [function, functional]

  rule initLoopInvariant(
      u(NumUsers:Int),
      UserIdToAddress:Map,
      AddressToUserId:Map,
      UserIdToRole:Map,
      Handling:PropertyHandling)
    => true
      andBool notBool u(0) in_keys(UserIdToAddress)
      andBool notBool u(0) in_keys(UserIdToRole)

      andBool mapsAreReverse(UserIdToAddress, AddressToUserId)

      // andBool mapValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      // andBool mapValuesBecomeKeys(UserIdToAddress, AddressToUserId)

      andBool addressToUserIdInvariant(AddressToUserId)
      // andBool mapValuesAreOfType(AddressToUserId, rUsize)
      // andBool mapValuesAreKResult(AddressToUserId)
      // andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)
      // andBool mapValuesAreDistinct(AddressToUserId)
      andBool mapValuesAreBelowLimit(NumUsers +Int 1, AddressToUserId, Handling)
      // andBool unusedIdsInMapValues(NumUsers +Int 1, AddressToUserId, Handling)

      andBool userIdToAddressInvariant(UserIdToAddress)

      andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToAddress), Handling)

      andBool userIdToRoleInvariant(UserIdToRole)
      // andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      // andBool mapValuesAreKResult(UserIdToRole)
      // andBool mapValuesAreNotEmpty(UserIdToRole, rUserRole)
      andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToRole), Handling)

      andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)

      andBool 0 ==Int mapCount(UserIdToRole, MEP.IsValue(Proposer))

  syntax TTCell ::= initLoopBodyLhs(
            /*prevIndex:*/Usize,
            K,
            /*userIdToAddress:*/Map,
            /*addressToUserId:*/Map,
            /*userIdToRole:*/Map,
            /*quorum:*/Usize,
            ActionStateCell,
            /*variables:*/Map,
            /*stack:*/Stack,
            ExternalCallEnvCell,
            /*address:*/Expression,
            /*userId:*/Usize)
      [function, functional]
  rule initLoopBodyLhs(
            PrevIndex:Usize,
            K:K,
            UserIdToAddress0:Map,
            AddressToUserId0:Map,
            UserIdToRole0:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Variables:Map,
            Stack:Stack,
            ExternalCallEnv:ExternalCallEnvCell,
            Address:Expression,
            UserId:Usize)
      => <TT>
          <k>
            runPseudoCode(
                user_id = i + u(1);
                require(getUserId(address) == u(0));
                setUserId(address, user_id);
                setUserAddress(user_id, address);
                setUserIdToRole(user_id, BoardMember);
            )
            ~> K
          </k>
          <state>
            <contract-state>
              <users>
                <num-users>u(0)</num-users>
                <user-id-to-address>UserIdToAddress0</user-id-to-address>
                <address-to-user-id>AddressToUserId0</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(0)</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole0</user-roles>
                <quorum>Quorum</quorum>
              </board-state>
              ActionState
            </contract-state>
            <pseudocode-state>
              <variables>
                i |-> PrevIndex
                address |-> Address
                user_id |-> UserId
                Variables
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
            ExternalCallEnv
            <log>
              <performed-actions>.List</performed-actions>
            </log>
          </state>
        </TT>

  syntax TTCell ::= initLoopBodyRhs(
            K,
            /*userIdToAddress:*/Map,
            /*addressToUserId:*/Map,
            /*userIdToRole:*/Map,
            /*quorum:*/Usize,
            ActionStateCell,
            /*variables:*/Map,
            /*stack:*/Stack,
            ExternalCallEnvCell,
            /*index:*/Usize,
            /*address:*/Expression,
            /*userId:*/Usize)
      [function, functional]
  rule initLoopBodyRhs(
            K:K,
            UserIdToAddress1:Map,
            AddressToUserId1:Map,
            UserIdToRole1:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Variables:Map,
            Stack:Stack,
            ExternalCallEnv:ExternalCallEnvCell,
            Index:Usize,
            Address:Expression,
            UserId:Usize)
      =>
        <TT>
          <k> evaluate(void) ~> K </k>
          <state>
            <contract-state>
              <users>
                <num-users>u(0)</num-users>
                <user-id-to-address>UserIdToAddress1</user-id-to-address>
                <address-to-user-id>AddressToUserId1:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(0)</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole1</user-roles>
                <quorum>Quorum</quorum>
              </board-state>
              ActionState
            </contract-state>
            <pseudocode-state>
              <variables>
                (i |-> Index)
                (address |-> Address)
                (user_id |-> UserId)
                Variables
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
            ExternalCallEnv
            <log>
              <performed-actions>.List</performed-actions>
            </log>
          </state>
        </TT>


endmodule
