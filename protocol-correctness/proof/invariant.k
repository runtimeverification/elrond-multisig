require "protocol-correctness/lib/functions/list-elements-are-distinct.k"
require "protocol-correctness/lib/functions/list-elements-are-usize.k"
require "protocol-correctness/lib/functions/map-keys-are-below-limit.k"
require "protocol-correctness/lib/functions/map-values-are-expression-list-of-usize.k"
require "protocol-correctness/lib/functions/map-values-are-kresult.k"
require "protocol-correctness/lib/functions/map-values-are-not-empty.k"
require "protocol-correctness/lib/functions/map-values-are-of-type.k"
require "protocol-correctness/lib/functions/maps-are-reverse.k"
require "protocol-correctness/lib/functions/value-is-not-empty.k"
require "protocol-correctness/lib/functions/value-not-in-map-values.k"
require "protocol-correctness/multisig/lib/language/type-reflection.k"
require "protocol-correctness/proof/execution-proof-helpers.k"
require "protocol-correctness/proof/map/map-execute.k"

module INVARIANT-HELPERS
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
  imports MAP-VALUES-ARE-DISTINCT-SYNTAX
  imports MAP-VALUES-ARE-EXPRESSION-LIST-OF-USIZE-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MULTISIG-TYPE-REFLECTION-SYNTAX
  imports VALUE-IS-NOT-EMPTY-SYNTAX
  imports VALUE-NOT-IN-MAP-VALUES-SYNTAX

  syntax Bool ::= addressToUserIdInvariant(addressToUserId:Map)
    [function, functional]

  rule addressToUserIdInvariant(.Map) => true

  rule addressToUserIdInvariant(_:KItem |-> V:KItem AddressToUserId:Map)
    => true
      andBool valueOfType(V, rUsize)  // mapValuesAreOfType(AddressToUserId, rUsize)
      andBool isKResult(V)  // mapValuesAreKResult(AddressToUserId)
      andBool valueIsNotEmpty(V, rUsize)  // mapValuesAreNotEmpty(AddressToUserId, rUsize)
      andBool valueNotInMapValues(V, AddressToUserId)  // mapValuesAreDistinct(AddressToUserId)

      andBool addressToUserIdInvariant(AddressToUserId)
    [simplification]

  syntax Bool ::= userIdToAddressInvariant(userIdToAddress:Map)
    [function, functional]

  rule userIdToAddressInvariant(.Map) => true

  rule userIdToAddressInvariant(K:KItem |-> V:KItem UserIdToAddress:Map)
    => true
      andBool valueOfType(V, rAddress)  // mapValuesAreOfType(UserIdToAddress, rAddress)
      andBool isKResult(V)  // mapValuesAreKResult(UserIdToAddress)
      // Address is not nullable.
      // andBool valueIsNotEmpty(V, rAddress)  // mapValuesAreNotEmpty(UserIdToAddress, rAddress)
      // TODO: Delete:
      // andBool V in_keys(AddressToUserId) andBool AddressToUserId[V] ==K K  // mapsAreReverseHalf(UserIdToAddress, AddressToUserId)

      andBool userIdToAddressInvariant(UserIdToAddress)
    ensures notBool K in_keys(UserIdToAddress)
    [simplification]

  syntax Bool ::= userIdToRoleInvariant(/*userIdToRole:*/Map)
    [function, functional]

  rule userIdToRoleInvariant(.Map) => true

  rule userIdToRoleInvariant(K:KItem |-> V:KItem UserIdToRole:Map)
    => true
      andBool valueOfType(V, rUserRole)  // mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool isKResult(V)  // mapValuesAreKResult(UserIdToRole)
      andBool valueIsNotEmpty(V, rUserRole)  // mapValuesAreNotEmpty(UserIdToRole, rUserRole)

      andBool valueOfType(K, rUsize)  // mapKeysAreOfType(UserIdToRole, rUsize)
      andBool isKResult(K)  // mapKeysAreKResult(UserIdToRole)

      andBool userIdToRoleInvariant(UserIdToRole)
    [simplification]


  syntax Bool ::= actionDataInvariant(actionData:Map)
    [function, functional]
  rule actionDataInvariant(.Map) => true
  rule actionDataInvariant(_:KItem |-> V:KItem ActionData:Map)
    => true
      andBool valueOfType(V, rAction) // mapValuesAreOfType(ActionData, rAction)
      andBool isKResult(V)  // mapValuesAreKResult(ActionData)
      andBool valueIsNotEmpty(V, rAction)  // mapValuesAreNotEmpty(ActionData, rAction)

      andBool actionDataInvariant(ActionData)
    [simplification]


  syntax Bool ::= actionSignersInvariant(actionSigners:Map)
    [function, functional]
  rule actionSignersInvariant(.Map) => true
  rule actionSignersInvariant(_:KItem |-> V:KItem ActionSigners:Map)
    => true
      andBool isExpressionList(V) andBool listElementsAreUsize(V) // mapValuesAreExpressionListOfUsize(ActionSigners)
      andBool isKResult(V)  // mapValuesAreKResult(ActionSigners)
      andBool valueIsNotEmpty(V, rExpressionList)  // mapValuesAreNotEmpty(ActionSigners, rExpressionList)
      andBool listElementsAreDistinctSafe(V)

      andBool actionSignersInvariant(ActionSigners)
    [simplification]

  rule mapValuesAreOfType(M:Map, rUsize) => true
    requires addressToUserIdInvariant(M)
  rule mapValuesAreOfType(M:Map, rUserRole) => true
    requires userIdToRoleInvariant(M)
  rule mapValuesAreOfType(M:Map, rAction) => true
    requires actionDataInvariant(M)
  rule mapValuesAreKResult(M:Map) => true
    requires false
      orBool addressToUserIdInvariant(M)
      orBool userIdToRoleInvariant(M)
      orBool actionSignersInvariant(M)
      orBool actionDataInvariant(M)
    [simplification]
  rule mapValuesAreNotEmpty(M:Map, rUsize) => true
    requires false
      orBool addressToUserIdInvariant(M)
    [simplification]
  rule mapValuesAreNotEmpty(M:Map, rUserRole) => true
    requires false
      orBool userIdToRoleInvariant(M)
    [simplification]
  rule mapValuesAreExpressionListOfUsize(M:Map) => true
    requires false
      orBool actionSignersInvariant(M)
    [simplification]
  rule mapValuesAreDistinct(M:Map) => true
    requires false
      orBool addressToUserIdInvariant(M)
    [simplification]
    
  rule isKResult(M[_K1:KItem] orDefault K2:KItem) => true
    requires actionSignersInvariant(M) andBool isKResult(K2)
    [simplification]

endmodule

module INVARIANT
  imports PSEUDOCODE
  imports INVARIANT-HELPERS
  imports MAP-EXECUTE-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-ARE-BELOW-LIMIT-SYNTAX
  imports MAPS-ARE-REVERSE-SYNTAX

  syntax StateCell ::= invariantState(
      /*numUsers:*/Usize,
      /*userIdToAddress:*/Map,
      /*addressToUserId:*/Map,
      /*numBoardMembers:*/Usize,
      /*numProposers:*/Usize,
      /*userIdToRole:*/Map,
      /*quorum:*/Usize,
      /*actionLastIndex:*/Usize,
      /*actionData:*/Map,
      /*actionSigners:*/Map,
      /*performedActions:*/List)  [function, functional]

  syntax ContractStateCell ::= invariantContractState(
      /*numUsers:*/Usize,
      /*userIdToAddress:*/Map,
      /*addressToUserId:*/Map,
      /*numBoardMembers:*/Usize,
      /*numProposers:*/Usize,
      /*userIdToRole:*/Map,
      /*quorum:*/Usize,
      /*actionLastIndex:*/Usize,
      /*actionData:*/Map,
      /*actionSigners:*/Map)  [function, functional]

  syntax StateCell ::= invariantStateStack(
      /*numUsers:*/Usize,
      /*userIdToAddress:*/Map,
      /*addressToUserId:*/Map,
      /*numBoardMembers:*/Usize,
      /*numProposers:*/Usize,
      /*userIdToRole:*/Map,
      /*quorum:*/Usize,
      /*actionLastIndex:*/Usize,
      /*actionData:*/Map,
      /*actionSigners:*/Map,
      /*callerAddress:*/CallerAddress,
      /*stack:*/Stack,
      /*performedActions:*/List)  [function, functional]

  syntax StateCell ::= invariantStateFull(
      /*numUsers:*/Usize,
      /*userIdToAddress:*/Map,
      /*addressToUserId:*/Map,
      /*numBoardMembers:*/Usize,
      /*numProposers:*/Usize,
      /*userIdToRole:*/Map,
      /*quorum:*/Usize,
      /*actionLastIndex:*/Usize,
      /*actionData:*/Map,
      /*actionSigners:*/Map,
      /*callerAddress:*/CallerAddress,
      /*stack:*/Stack,
      /*variables:*/Map,
      /*performedActions:*/List)  [function, functional]

  rule invariantState(
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
    =>
      invariantStateStack(
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
          uninitialized,
          .stack,
          PerformedActions)

  rule invariantStateStack(
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
      CallerAddress:CallerAddress,
      Stack:Stack,
      PerformedActions:List)
    => invariantStateFull(
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
          CallerAddress,
          Stack,
          .Map,
          PerformedActions)

  rule invariantStateFull(
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
      CallerAddress:CallerAddress,
      Stack:Stack,
      Variables:Map,
      PerformedActions:List)
    =>
      <state>
        invariantContractState(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionSigners):ContractStateCell
        <pseudocode-state>
          <variables>Variables</variables>
          <stack> Stack </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>CallerAddress</caller-address>
        </external-call-env>
        <log>
          <performed-actions>PerformedActions</performed-actions>
        </log>
      </state>

  rule invariantContractState(
      NumUsers:Usize,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      NumBoardMembers:Usize,
      NumProposers:Usize,
      UserIdToRole:Map,
      Quorum:Usize,
      ActionLastIndex:Usize,
      ActionData:Map,
      ActionSigners:Map)
    =>
        <contract-state>
          <users>
            <num-users>NumUsers</num-users>
            <user-id-to-address>UserIdToAddress</user-id-to-address>
            <address-to-user-id>AddressToUserId</address-to-user-id>
          </users>
          <board-state>
            <num-board-members>NumBoardMembers</num-board-members>
            <num-proposers>NumProposers</num-proposers>
            <user-roles>UserIdToRole</user-roles>
            <quorum>Quorum</quorum>
          </board-state>
          <action-state>
            <action-last-index>ActionLastIndex</action-last-index>
            <actions>
              <action-data>ActionData</action-data>
              <action-signers>ActionSigners</action-signers>
            </actions>
          </action-state>
        </contract-state>

  syntax Bool ::= baseInvariant(
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize,
      actionLastIndex:Usize,
      actionData:Map,
      actionSigners:Map,
      handling:PropertyHandling)  [function, functional]

  rule baseInvariant(
      u(NumUsers:Int),
      UserIdToAddress:Map,
      AddressToUserId:Map,
      u(NumBoardMembers:Int),
      u(NumProposers:Int),
      UserIdToRole:Map,
      u(Quorum:Int),
      u(ActionLastIndex:Int),
      ActionData:Map,
      ActionSigners:Map,
      Handling:PropertyHandling)
    => true
      andBool notBool u(0) in_keys(UserIdToAddress)
      andBool notBool u(0) in_keys(UserIdToRole)

      // andBool mapValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      // andBool mapValuesBecomeKeys(UserIdToAddress, AddressToUserId)

      andBool mapsAreReverse(UserIdToAddress, AddressToUserId)

      andBool addressToUserIdInvariant(AddressToUserId)
      // andBool mapValuesAreOfType(AddressToUserId, rUsize)
      // andBool mapValuesAreKResult(AddressToUserId)
      // andBool mapValuesAreNotEmpty(AddressToUserId, rUsize)
      // andBool mapValuesAreDistinct(AddressToUserId)
      // andBool unusedIdsInMapValues(NumUsers +Int 1, AddressToUserId, Handling)
      andBool mapValuesAreBelowLimit(NumUsers +Int 1, AddressToUserId, Handling)

      andBool userIdToAddressInvariant(UserIdToAddress)

      andBool mapKeysAreBelowLimit(NumUsers +Int 1, keysMap(UserIdToAddress), Handling)

      andBool userIdToRoleInvariant(UserIdToRole)
      // andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      // andBool mapValuesAreKResult(UserIdToRole)
      // andBool mapValuesAreNotEmpty(UserIdToRole, rUserRole)
      andBool mapKeysAreBelowLimit(NumUsers +Int 1, keysMap(UserIdToRole), Handling)
      andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)

      andBool mapKeysAreBelowLimit(ActionLastIndex +Int 1, keysMap(ActionData), Handling)
      andBool mapKeysAreBelowLimit(ActionLastIndex +Int 1, keysMap(ActionSigners), Handling)
      andBool maxMapKey(u(ActionLastIndex), keysMap(ActionData))
      andBool maxMapKey(u(ActionLastIndex), keysMap(ActionSigners))

      andBool actionSignersInvariant(ActionSigners)
      // andBool mapValuesAreExpressionListOfUsize(ActionSigners)
      // andBool mapValuesAreKResult(ActionSigners)
      // andBool valuesAreExpressionListOfDistinctElements(ActionSigners)

      andBool actionDataInvariant(ActionData)
      // andBool mapValuesAreOfType(ActionData, rAction)
      // andBool mapValuesAreKResult(ActionData)

      andBool NumUsers >=Int 0 // TODO: Strict >?
      andBool NumBoardMembers >=Int 0
      andBool NumProposers >=Int 0

      andBool Quorum <=Int NumBoardMembers
      andBool (NumBoardMembers +Int NumProposers >Int 0)

      andBool NumBoardMembers ==Int mapCount(UserIdToRole, MEP.IsValue(BoardMember))
      andBool NumProposers ==Int mapCount(UserIdToRole, MEP.IsValue(Proposer))

  // CustomInvariantData and customInvariant are defined differently for each
  // group of proofs.
  syntax CustomInvariantData
  syntax Bool ::= customInvariant(
      CustomInvariantData,
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize,
      actionLastIndex:Usize,
      actionData:Map,
      actionSigners:Map,
      handling:PropertyHandling)  [function, functional]

  syntax Bool ::= invariant(
      CustomInvariantData,
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize,
      actionLastIndex:Usize,
      actionData:Map,
      actionSigners:Map,
      handling:PropertyHandling)  [function, functional]
  rule invariant(
      CustomData:CustomInvariantData,
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
      Handling:PropertyHandling)
    => true
      andBool baseInvariant(
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
          Handling)
      andBool customInvariant(
          CustomData,
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
          Handling)

  // TODO: Maybe move somewhere else.
  syntax Bool ::= subset(Map, Map)  [function, functional]
  rule subset(K:KItem |-> _:KItem M:Map, N:Map)
      => K in_keys(N) andBool subset(M, N)
    [simplification]
  rule subset(M:Map, _:KItem |-> _:KItem N:Map)
      => true
    requires subset(M, N)
    [simplification]

  syntax Bool ::= maxMapKey(lastIndex:Usize, Map)  [function, functional]
  rule maxMapKey(_:Usize, .Map) => true
  rule maxMapKey(u(V:Int), u(K:Int) |-> _:KItem M:Map)
      => (K <=Int V) andBool maxMapKey(u(V), M)
  rule maxMapKey(u(V:Int), u(K:Int) |-> _:KItem M:Map)
      => (K <=Int V) andBool maxMapKey(u(V), M)
    [simplification]
  rule maxMapKey(u(V:Int +Int 1), M:Map)
      => true
    requires maxMapKey(u(V:Int), M:Map)
    [simplification]

  rule isKResult(#pushList(Es:ExpressionCSV, E:Expression))
    => isKResult(Es) andBool isKResult(E)
    [simplification]
  rule isKResultExpressionCSV(#pushList(Es:ExpressionCSV, E:Expression))
    => isKResult(Es) andBool isKResult(E)
    [simplification]

  rule listElementsAreUsize([#pushList(Es:ExpressionCSV, E:Expression)])
    => listElementsAreUsize([Es]) andBool isUsize(E)
    [simplification]

  rule isKResult(#listSwapRemove(Es:ExpressionCSV, _:Int)) => true
    requires isKResult(Es)
    [simplification]
  rule isKResultExpressionCSV(#listSwapRemove(Es:ExpressionCSV, _:Int)) => true
    requires isKResultExpressionCSV(Es)
    [simplification]

  rule listElementsAreUsize([#listSwapRemove(Es:ExpressionCSV, _:Int)]) => true
    requires listElementsAreUsize([Es])
    [simplification]

  rule A:Int +Int K:Int >Int B:Int => true
    requires K >Int 0 andBool A >=Int B
    [simplification]

endmodule
