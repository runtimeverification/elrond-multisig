require "protocol-correctness/multisig/lib/functions/only-this-signer-diffs.k"
require "protocol-correctness/proof/main-proof-execute.k"
require "protocol-correctness/proof/invariant/invariant-execute.k"
require "protocol-correctness/proof/properties/properties-execute.k"

module MALICIOUS-USER-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-SYNTAX
endmodule

module MALICIOUS-USER-INVARIANT-FUNCTIONS
  imports K-EQUAL-SYNTAX
  imports MAP
  imports PSEUDOCODE-SYNTAX

  syntax Bool ::= onlyThisSigner(addressToUserId:Map, Address, actionSigners:Map)
      [function, functional]

  rule  onlyThisSigner(
            _AddressToUserId:Map,
            _Address:Address,
            .Map)
      => true
  rule  onlyThisSigner(
            AddressToUserId:Map,
            Address:Address,
            _Key |-> Signers ActionSigners:Map)
      =>
        #if Address in_keys(AddressToUserId)
        #then oneElementList(AddressToUserId[Address] orDefault void, Signers)
        #else false
        #fi
        andBool onlyThisSigner(AddressToUserId, Address, ActionSigners)
    [simplification]

  syntax Bool ::= oneElementList(element:KItem, ExpressionList) [function, functional]
  rule oneElementList(E:Expression, L:ExpressionList) => L ==K [E, .]
  rule oneElementList(_, _) => false [owise]
endmodule

module MALICIOUS-USER-INVARIANT
  imports INVARIANT
  imports MALICIOUS-USER-INVARIANT-FUNCTIONS
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports PSEUDOCODE-FUNCTIONS-SYNTAX

  syntax CustomInvariantData ::= Address

  rule  customInvariant(
            MaliciousAddress:Address,
            _NumUsers:Usize,
            _UserIdToAddress:Map,
            AddressToUserId:Map,
            _NumBoardMembers:Usize,
            _NumProposers:Usize,
            _UserRoles:Map,
            u(Quorum:Int),
            _ActionLastIndex:Usize,
            _ActionData:Map,
            ActionSigners:Map,
            _Handling:PropertyHandling)
      => true
        andBool onlyThisSigner(AddressToUserId, MaliciousAddress, ActionSigners)
        andBool Quorum >=Int 2

  // TODO: Delete.
  syntax Bool ::= maliciousInvariant(
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

  rule  maliciousInvariant(
            MaliciousAddress:Address,
            NumUsers:Usize,
            // InitialUserIdToAddress:Map,
            CurrentUserIdToAddress:Map,
            // InitialAddressToUserId:Map,
            CurrentAddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserRoles:Map,
            u(Quorum:Int),
            ActionLastIndex:Usize,
            ActionData:Map,
            ActionSigners:Map,
            Handling:PropertyHandling)
      => true
        andBool baseInvariant(
            NumUsers,
            CurrentUserIdToAddress,
            CurrentAddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserRoles,
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ActionSigners,
            Handling)
        andBool onlyThisSigner(CurrentAddressToUserId, MaliciousAddress, ActionSigners)
        andBool Quorum >=Int 2

  syntax Bool ::= listQuorumCantBeFilledBy(
                      quorum:Int, id:Usize, signers:ExpressionList, userIdToRole:Map
                  )  [function, functional]
  rule listQuorumCantBeFilledBy(
          Quorum:Int, UserId:Usize, Signers:ExpressionList, UserIdToRole:Map
      )
      =>  countCanSignFunction(Signers, UserIdToRole)
            +Int #if #listContainsSafe(Signers, UserId) #then 0 #else 1 #fi
          <Int Quorum

  syntax Bool ::= noQuorumCanBeFilledBy(quorum:Int, id:Usize, signers:Map, userIdToRole:Map)  [function, functional]
  rule noQuorumCanBeFilledBy(_Quorum:Int, _UserId:Usize, .Map, _UserIdToRole:Map) => true
  rule noQuorumCanBeFilledBy(
          Quorum:Int,
          UserId:Usize,
          _:KItem |-> L:ExpressionList M:Map,
          UserIdToRole:Map)
      => true
        andBool listQuorumCantBeFilledBy(Quorum, UserId:Usize, L, UserIdToRole)
        andBool noQuorumCanBeFilledBy(Quorum:Int, UserId:Usize, M:Map, UserIdToRole)
    [simplification]
endmodule

module MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports INT

  syntax KItem ::= runExternalCallsFromUser(Address, steps:Int)
  syntax KItem ::= runExternalCallFromUser(Address)
endmodule

module MALICIOUS-USER-EXTERNAL-CALLS
  imports CONCRETIZE-VALUE-SYNTAX
  imports PSEUDOCODE-SYNTAX
  imports INSTRUMENTATION-CONCRETIZE
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX
  imports INSTRUMENTATION-PROOF

  syntax KResult

  rule runExternalCallsFromUser(_:Address, Steps:Int) => .K
    requires Steps <=Int 0  [label(runExternalCallsFUStepsLE0)]
  rule runExternalCallsFromUser(A:Address, Steps:Int)
      => runExternalCallFromUser(A) ~> runExternalCallsFromUser(A, Steps -Int 1)
    requires Steps >Int 0  [label(runExternalCallsFUStepsGT0)]

  rule  runExternalCallFromUser(A:Address)
        => runExternalCall(from A run proposeAddBoardMember(?_UserAddress:Address);)
    [label(runProposeAddBoardMember)]
  rule  runExternalCallFromUser(A:Address)
        => runExternalCall(from A run proposeAddProposer(?_UserAddress:Address);)
    [label(runProposeAddBoardProposer)]
  rule  runExternalCallFromUser(A:Address)
        => runExternalCall(from A run proposeRemoveUser(?_UserAddress:Address);)
    [label(runProposeRemoveUser)]
  rule  runExternalCallFromUser(A:Address)
        => runExternalCall(from A run proposeChangeQuorum(?_Quorum:Usize);)
    [label(runProposeChangeQuorum)]
  rule  runExternalCallFromUser(A:Address)
        => runExternalCall(from A run proposeSendEgld(
            ?_To:Address, ?_Amount:BigUint, ?_Data:BoxedBytes);)
    [label(runProposeSendEgld)]
  rule  runExternalCallFromUser(A:Address)
        =>  concretizeValue(?Amount)
            ~> concretizeValue(?Code)
            ~> concretizeValue(?Args)
            ~> runExternalCall(from A run proposeSCDeploy(
                  ?Amount:BigUint,
                  ?Code:BoxedBytes,
                  ?_Upgradeable:Bool,
                  ?_Payable:Bool,
                  ?_Readable:Bool,
                  ?Args:ExpressionList);)
    ensures isKResult(?Args)
    [label(runProposeSCDeploy)]
  rule  runExternalCallFromUser(A:Address)
        => concretizeValue(?To)
            ~> concretizeValue(?Amount)
            ~> concretizeValue(?Function)
            ~> concretizeValue(?Args)
            ~> runExternalCall(from A run proposeSCCall(
                ?To:Address,
                ?Amount:BigUint,
                ?Function:BoxedBytes,
                ?Args:ExpressionList);)
    ensures isKResult(?Args)
    [label(runProposeSCCall)]
  rule  <k> runExternalCallFromUser(A:Address)
          => branchK(A in_keys(AddressToUserId),
                  makeConcreteValue(A, rUsize, AddressToUserId)
                    ~>  branchK(AddressToUserId[A] orDefault void in_keys(UserIdToRole),
                            makeConcreteValue(AddressToUserId[A] orDefault void, rUserRole, UserIdToRole),
                            .K
                        ),
                  .K
              )
            ~> concretizeValue(?ActionId)
            ~> concretizeValue(?ActionId in_keys(ActionData))
            ~> runExternalCall(from A run sign(?ActionId:Usize);)
          ...
        </k>
        <address-to-user-id>
          AddressToUserId:Map
        </address-to-user-id>
        <user-roles>
          UserIdToRole:Map
        </user-roles>
        <action-data>
          ActionData:Map
        </action-data>
    [label(runSign)]
  // rule  runExternalCallFromUser(A:Address)
  //         =>  runExternalCall(from A run unsign(?_ActionId:Usize);)
  rule  <k> runExternalCallFromUser(A:Address)
          =>  branchK(A in_keys(AddressToUserId),
                  makeConcreteValue(A, rUsize, AddressToUserId)
                    ~>  branchK(AddressToUserId[A] orDefault void in_keys(UserIdToRole),
                            makeConcreteValue(AddressToUserId[A] orDefault void, rUserRole, UserIdToRole),
                            .K
                        ),
                  .K
              )
              ~> concretizeValue(?ActionId)
              ~> concretizeValue(?ActionId in_keys(ActionData))
              ~> runExternalCall(from A run unsign(?ActionId:Usize);)
          ...
        </k>
        <address-to-user-id>
          AddressToUserId:Map
        </address-to-user-id>
        <user-roles>
          UserIdToRole:Map
        </user-roles>
        <action-data>
          ActionData:Map
        </action-data>
    [label(runUnsign)]
  rule  runExternalCallFromUser(A:Address)
        => runExternalCall(from A run performActionEndpoint(?_ActionId:Usize);)
    [label(runPerformAction)]
  rule  <k> runExternalCallFromUser(A:Address)
            =>  concretizeValue(?ActionId)
                ~>  branchK(?ActionId in_keys(ActionSigners),
                      makeConcreteValue(?ActionId, rExpressionList, ActionSigners),
                      .K
                    )
                ~>  runExternalCall(from A run discardAction(?ActionId:Usize);)
            ...
        </k>
        <action-signers>
          ActionSigners:Map
        </action-signers>
    [label(runDiscardAction)]
endmodule

module MALICIOUS-USER-EXECUTE
  imports MAIN-PROOF-EXECUTE
  // imports FUNCTIONS-EXECUTE
  imports PROPERTIES-EXECUTE

  imports INIT-LOOP-PARTS

  imports MALICIOUS-USER-INVARIANT
  imports MALICIOUS-USER-EXTERNAL-CALLS
endmodule