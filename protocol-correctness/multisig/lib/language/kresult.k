require "protocol-correctness/multisig/lib/language/syntax.k"

module MULTISIG-KRESULT-SYNTAX
  imports MULTISIG-SYNTAX

  syntax Bool ::= isKResultAction(Action)  [function, functional]
endmodule

module MULTISIG-KRESULT
  imports MULTISIG-KRESULT-SYNTAX
  imports MULTISIG-SYNTAX

  rule isKResultAction(Nothing) => true
  rule isKResultAction(AddBoardMember(A:Address)) => isKResult(A)
  rule isKResultAction(AddProposer(A:Address)) => isKResult(A)
  rule isKResultAction(RemoveUser(A:Address)) => isKResult(A)
  rule isKResultAction(ChangeQuorum(U:Usize)) => isKResult(U)
  rule  isKResultAction(SendEgld(To:Address, Amount:BigUint, Data:BoxedBytes))
        => isKResult(To) andBool isKResult(Amount) andBool isKResult(Data)
  rule  isKResultAction(SCDeploy(
                        Amount:BigUint,
                        Code:BoxedBytes,
                        CodeMetadata:CodeMetadata,
                        Arguments:ExpressionList))
        => isKResult(Amount)
            andBool isKResult(Code)
            andBool isKResult(CodeMetadata)
            andBool isKResult(Arguments)
  rule isKResultAction(SCCall(
                        To:Address,
                        Amount:BigUint,
                        Function:BoxedBytes,
                        Arguments:ExpressionList))
        => isKResult(To)
            andBool isKResult(Amount)
            andBool isKResult(Function)
            andBool isKResult(Arguments)

  rule isKResultExpression(A:Action) => isKResultAction(A)
endmodule