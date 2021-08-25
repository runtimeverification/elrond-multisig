require "protocol-correctness/lib/language/language.k"

module PSEUDOCODE-SYNTAX
  imports TOKEN-IDENTIFIER-SYNTAX
  imports MEX-IDENTIFIERS-SYNTAX
  imports PAIR-BASE-SYNTAX
  // imports INT
  // imports LIST
  // imports STRING

  // imports BASE-TYPES-SYNTAX
  // imports RUNNING-SYNTAX

  // syntax CodeMetadata ::= "CodeMetadata::DEFAULT"     [function]
  //                     |   "CodeMetadata::UPGRADEABLE" [function]
  //                     |   "CodeMetadata::PAYABLE"     [function]
  //                     |   "CodeMetadata::READABLE"    [function]

  // syntax CodeMetadata ::= meta(Int)  // Assumes no operations on this.
  // syntax UserRole ::= "None" | "Proposer" | "BoardMember"
  // syntax Action ::= "Nothing"
  //               |   AddBoardMember(Address)
  //               |   AddProposer(Address)
  //               |   RemoveUser(Address)
  //               |   ChangeQuorum(Usize)
  //               |   SendEgld(to: Address, amount: BigUint, data: BoxedBytes)
  //               |   SCDeploy(
  //                       amount: BigUint,
  //                       code: BoxedBytes,
  //                       codeMetadata: CodeMetadata,
  //                       arguments: ExpressionList)  // list of BoxedBytes
  //               |   SCCall(
  //                       to: Address,
  //                       amount: BigUint,
  //                       function: BoxedBytes,
  //                       arguments: ExpressionList)  // list of BoxedBytes

  // syntax Value  ::= UserRole
  //               |   CodeMetadata
  // syntax Expression ::= Action

endmodule

module PSEUDOCODE-KRESULT
  // imports PSEUDOCODE-SYNTAX
  // syntax Bool ::= isKResultAction(Action)  [function, functional]

  // rule isKResultAction(Nothing) => true
  // rule isKResultAction(AddBoardMember(A:Address)) => isKResult(A)
  // rule isKResultAction(AddProposer(A:Address)) => isKResult(A)
  // rule isKResultAction(RemoveUser(A:Address)) => isKResult(A)
  // rule isKResultAction(ChangeQuorum(U:Usize)) => isKResult(U)
  // rule  isKResultAction(SendEgld(To:Address, Amount:BigUint, Data:BoxedBytes))
  //       => isKResult(To) andBool isKResult(Amount) andBool isKResult(Data)
  // rule  isKResultAction(SCDeploy(
  //                       Amount:BigUint,
  //                       Code:BoxedBytes,
  //                       CodeMetadata:CodeMetadata,
  //                       Arguments:ExpressionList))
  //       => isKResult(Amount)
  //           andBool isKResult(Code)
  //           andBool isKResult(CodeMetadata)
  //           andBool isKResult(Arguments)
  // rule isKResultAction(SCCall(
  //                       To:Address,
  //                       Amount:BigUint,
  //                       Function:BoxedBytes,
  //                       Arguments:ExpressionList))
  //       => isKResult(To)
  //           andBool isKResult(Amount)
  //           andBool isKResult(Function)
  //           andBool isKResult(Arguments)

  // rule isKResultExpression(A:Action) => isKResultAction(A)
endmodule

module PSEUDOCODE
  imports LANGUAGE
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-EXPRESSION
  imports PSEUDOCODE-FUNCTION-CALL
  imports PSEUDOCODE-FUNCTIONS
  imports PSEUDOCODE-KRESULT
  imports PSEUDOCODE-SYNTAX
endmodule

module PSEUDOCODE-TYPE-REFLECTION
  // imports FLOW-SYNTAX
  // imports PSEUDOCODE-SYNTAX
  // imports TYPE-REFLECTION-SYNTAX

  // syntax ReflectionType ::= "rUserRole"
  //                       |   "rAction"
  //                       |   "rCodeMetadata"

  // rule cast(U:UserRole, rUserRole) => U  [label(castUserRole)]
  // rule (.K => stuck) ~> cast(V:KItem, rUserRole)
  //   ensures notBool isUserRole(V)
  //   [owise, label(castUserRoleStuck)]

  // rule cast(A:Action, rAction) => A  [label(castAction)]
  // rule (.K => stuck) ~> cast(V:KItem, rAction)
  //   ensures notBool isAction(V)
  //   [owise, label(castActionStuck)]

  // rule defaultValue(rUserRole) => None
  // rule defaultValue(rAction) => Nothing
  // rule defaultValue(rCodeMetadata) => CodeMetadata::DEFAULT

  // rule valueOfType(V:KItem, rUserRole) => isUserRole(V)
  // rule valueOfType(V:KItem, rAction) => isAction(V)
  // rule valueOfType(V:KItem, rCodeMetadata) => isCodeMetadata(V)
endmodule

module PSEUDOCODE-EXPRESSION
  // imports EXPRESSION-SYNTAX
  // imports PSEUDOCODE-SYNTAX
  // imports RUNNING-SYNTAX

  // rule evaluate((meta(A:Int) | meta(B:Int)) => meta(A |Int B))
endmodule

module PSEUDOCODE-FUNCTIONS-SYNTAX
  // imports BOOL
  // imports INT

  // imports PSEUDOCODE-SYNTAX

  // imports ADD-ONE-IF-NOT-NEGATIVE-SYNTAX
  // imports LAST-FUNCTIONS-SYNTAX
  // imports LAST-TO-START-SYNTAX
  // imports LIST-CONTAINS-SYNTAX
  // imports LIST-FIND-SYNTAX
  // imports LIST-SWAP-REMOVE-SYNTAX
  // imports PLISTLEN-FUNCTIONS-SYNTAX
  // imports PREPEND-SYNTAX
  // imports PUSH-LIST-SYNTAX
  // imports REMOVE-LAST-SYNTAX

  // syntax KResult

  // syntax FunctionTag ::= "proposeActionSCDeploy"

  // syntax KItem ::= "plusOne"

  // syntax ExpressionCSV ::= reverseExpressionCsv(ExpressionCSV, ExpressionCSV)  [function, functional]

  // syntax Int ::= metadataToInt(CodeMetadata)  [function, functional]

  // syntax CodeMetadata ::= codeMetadataFunction(upgradeable:Bool, payable:Bool, readable:Bool)
  //     [function, functional]

endmodule

module PSEUDOCODE-FUNCTION-CALL
  imports PSEUDOCODE-CONFIGURATION
  imports FUNCTION-CALL-SYNTAX

  syntax CustomStackState ::= customStackState(BlockchainStateCell, LogCell)

  rule  <k> getCustomStackState => customStackState(C, Log) ... </k>
        <state>
          C:BlockchainStateCell
          _:PseudocodeStateCell
          _:ExternalCallEnvCell
          Log:LogCell
        </state>

  rule  <k> setCustomStackState(customStackState(C:BlockchainStateCell, Log:LogCell)) => .K ... </k>
        <state>
          (_:BlockchainStateCell => C)
          _:PseudocodeStateCell
          _:ExternalCallEnvCell
          (_:LogCell => Log)
        </state>
endmodule

module PSEUDOCODE-CONFIGURATION
  imports MAP

  imports LANGUAGE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  configuration
    <T>
      <TT>
        <k />
        <state>
          <blockchain-state>
            .K
          </blockchain-state>
          <pseudocode-state />
          <external-call-env />
          <log>
            <performed-actions>.List</performed-actions>
          </log>
        </state>
    </TT>
  </T>

  syntax StateCell ::= "initialState"   [function]
  rule initialState =>
      <state>
        <blockchain-state>
          .K
        </blockchain-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .stack </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>uninitialized</caller-address>
        </external-call-env>
        <log>
          <performed-actions>.List</performed-actions>
        </log>
      </state>
endmodule
