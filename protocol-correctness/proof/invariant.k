require "protocol-correctness/proof/execution-proof-helpers.k"

module INVARIANT-HELPERS
  imports EXECUTION-PROOF-HELPERS

  syntax Bool ::= addressToUserIdInvariant(addressToUserId:Map)
    [function, functional]

  rule addressToUserIdInvariant(.Map) => true

  rule addressToUserIdInvariant(_:KItem |-> V:KItem AddressToUserId:Map)
    => true
      andBool valueOfType(V, rUsize)  // valuesAreOfType(AddressToUserId, rUsize)
      andBool isKResult(V)  // valuesAreKResult(AddressToUserId)
      andBool valueIsNotEmpty(V, rUsize)  // valuesAreNotEmpty(AddressToUserId, rUsize)
      andBool valueNotInMapValues(V, AddressToUserId)  // valuesAreDistinct(AddressToUserId)

      andBool addressToUserIdInvariant(AddressToUserId)
    [simplification]

  syntax Bool ::= userIdToAddressInvariant(userIdToAddress:Map)
    [function, functional]

  rule userIdToAddressInvariant(.Map) => true

  rule userIdToAddressInvariant(K:KItem |-> V:KItem UserIdToAddress:Map)
    => true
      andBool valueOfType(V, rAddress)  // valuesAreOfType(UserIdToAddress, rAddress)
      andBool isKResult(V)  // valuesAreKResult(UserIdToAddress)
      // Address is not nullable.
      // andBool valueIsNotEmpty(V, rAddress)  // valuesAreNotEmpty(UserIdToAddress, rAddress)
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
      andBool valueOfType(V, rUserRole)  // valuesAreOfType(UserIdToRole, rUserRole)
      andBool isKResult(V)  // valuesAreKResult(UserIdToRole)
      andBool valueIsNotEmpty(V, rUserRole)  // valuesAreNotEmpty(UserIdToRole, rUserRole)

      andBool valueOfType(K, rUsize)  // keysAreOfType(UserIdToRole, rUsize)
      andBool isKResult(K)  // keysAreKResult(UserIdToRole)

      andBool userIdToRoleInvariant(UserIdToRole)
    [simplification]


  syntax Bool ::= actionDataInvariant(actionData:Map)
    [function, functional]
  rule actionDataInvariant(.Map) => true
  rule actionDataInvariant(_:KItem |-> V:KItem ActionData:Map)
    => true
      andBool valueOfType(V, rAction) // valuesAreOfType(ActionData, rAction)
      andBool isKResult(V)  // valuesAreKResult(ActionData)
      andBool valueIsNotEmpty(V, rAction)  // valuesAreNotEmpty(ActionData, rAction)

      andBool actionDataInvariant(ActionData)
    [simplification]


  syntax Bool ::= actionSignersInvariant(actionSigners:Map)
    [function, functional]
  rule actionSignersInvariant(.Map) => true
  rule actionSignersInvariant(_:KItem |-> V:KItem ActionSigners:Map)
    => true
      andBool isExpressionList(V) andBool listElementsAreUsize(V) // valuesAreExpressionListOfUsize(ActionSigners)
      andBool isKResult(V)  // valuesAreKResult(ActionSigners)
      andBool valueIsNotEmpty(V, rExpressionList)  // valuesAreNotEmpty(ActionSigners, rExpressionList)
      andBool listElementsAreDistinctSafe(V)

      andBool actionSignersInvariant(ActionSigners)
    [simplification]

  rule valuesAreOfType(M:Map, rUsize) => true
    requires addressToUserIdInvariant(M)
  rule valuesAreOfType(M:Map, rUserRole) => true
    requires userIdToRoleInvariant(M)
  rule valuesAreOfType(M:Map, rAction) => true
    requires actionDataInvariant(M)
  rule valuesAreKResult(M:Map) => true
    requires false
      orBool addressToUserIdInvariant(M)
      orBool userIdToRoleInvariant(M)
      orBool actionSignersInvariant(M)
      orBool actionDataInvariant(M)
  rule valuesAreNotEmpty(M:Map, rUsize) => true
    requires false
      orBool addressToUserIdInvariant(M)
  rule valuesAreNotEmpty(M:Map, rUserRole) => true
    requires false
      orBool userIdToRoleInvariant(M)
  rule valuesAreExpressionListOfUsize(M:Map) => true
    requires false
      orBool actionSignersInvariant(M)
  rule valuesAreDistinct(M:Map) => true
    requires false
      orBool addressToUserIdInvariant(M)
    
  rule isKResult(M[K1:KItem] orDefault K2:KItem) => true
    requires actionSignersInvariant(M) andBool isKResult(K2)
    [simplification]

endmodule

module INVARIANT
  imports EXECUTION-PROOF-HELPERS
  imports PSEUDOCODE
  imports INVARIANT-HELPERS

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

      // andBool allValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      // andBool allValuesBecomeKeys(UserIdToAddress, AddressToUserId)

      andBool mapsAreReverseHalf(UserIdToAddress, AddressToUserId)
      andBool mapsAreReverseHalf(AddressToUserId, UserIdToAddress)

      andBool addressToUserIdInvariant(AddressToUserId)
      // andBool valuesAreOfType(AddressToUserId, rUsize)
      // andBool valuesAreKResult(AddressToUserId)
      // andBool valuesAreNotEmpty(AddressToUserId, rUsize)
      // andBool valuesAreDistinct(AddressToUserId)
      andBool unusedIdsInMapValues(NumUsers +Int 1, AddressToUserId, Handling)
      andBool noReusedIndexValue(NumUsers +Int 1, AddressToUserId, Handling)

      andBool userIdToAddressInvariant(UserIdToAddress)

      andBool unusedIdsInMapKeys(NumUsers +Int 1, keysMap(UserIdToAddress), Handling)

      andBool userIdToRoleInvariant(UserIdToRole)
      // andBool valuesAreOfType(UserIdToRole, rUserRole)
      // andBool valuesAreKResult(UserIdToRole)
      // andBool valuesAreNotEmpty(UserIdToRole, rUserRole)
      andBool unusedIdsInMapKeys(NumUsers +Int 1, keysMap(UserIdToRole), Handling)
      andBool allKeysBecomeKeys(UserIdToRole, UserIdToAddress)

      andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionData), Handling)
      andBool unusedIdsInMapKeys(ActionLastIndex +Int 1, keysMap(ActionSigners), Handling)
      andBool maxMapKey(u(ActionLastIndex), keysMap(ActionData))
      andBool maxMapKey(u(ActionLastIndex), keysMap(ActionSigners))

      andBool actionSignersInvariant(ActionSigners)
      // andBool valuesAreExpressionListOfUsize(ActionSigners)
      // andBool valuesAreKResult(ActionSigners)
      // andBool valuesAreExpressionListOfDistinctElements(ActionSigners)

      andBool actionDataInvariant(ActionData)
      // andBool valuesAreOfType(ActionData, rAction)
      // andBool valuesAreKResult(ActionData)

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
