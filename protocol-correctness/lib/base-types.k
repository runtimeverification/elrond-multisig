module BASE-TYPES-SYNTAX
  imports BOOL
  imports INT
  imports STRING

  syntax Usize ::= u(Int)  // TODO: int32
  syntax BigUint ::= big(Int)  // Assumes no operations on this.
  syntax BoxedBytes ::= bytes(String)
  syntax Address ::= address(Int)
  syntax Variable ::= r"[A-Za-z_][A-Za-z_0-9]*" [token]

  syntax ExternalCommands ::= ExternalCommand
                          |   ExternalCommand ExternalCommands
  syntax ExternalCommand  ::= "from" Address "run" EndpointCall ";"

  syntax Block ::= "{" Instructions "}"
  syntax Instructions ::= Instruction
                      |   Instruction Instructions
  syntax Instruction  ::= "require" "(" Expression ")" ";"
                      |   Variable "=" Expression ";"
                      |   "if" "(" Expression ")" Block               [avoid]
                      |   "if" "(" Expression ")" Block "else" Block  [prefer]
                      |   "for" "(" index:Variable "," value:Variable ")" "in" Expression Block
                      |   Expression ";"
                      |   "ok" "(" Expression ")" ";"

  syntax Value  ::= Usize
                |   "void"
                |   Bool
                |   Address
                |   BoxedBytes
                |   BigUint

  syntax Expression ::= FunctionCall
                    |   Variable
                    |   ExpressionList
                    |   Value
                    |   Expression "+" Expression
                    |   Expression "-" Expression
                    |   Expression "|" Expression
                    >   Expression "==" Expression
                    |   Expression "<=" Expression
                    |   Expression ">" Expression
                    |   "!" Expression

  syntax ExpressionCSV  ::= "."
                        |   Expression "," ExpressionCSV

  syntax ArgumentCSV  ::= Expression
                      |   Expression "," ArgumentCSV

  syntax ExpressionList ::= "[" ExpressionCSV "]"

  syntax FunctionCall ::= FunctionTag "(" ")"
                      |   FunctionTag "(" ArgumentCSV ")"

  syntax FunctionTag ::= EndpointTag
  syntax EndpointTag

  syntax EndpointCall ::= EndpointTag "(" ")"
                      |   EndpointTag "(" ArgumentCSV ")"

  syntax Bool ::= isKResultExpression(Expression)  [function, functional]
  syntax Bool ::= isKResultArgumentCSV(ArgumentCSV)  [function, functional]
  syntax Bool ::= isKResultExpressionCSV(ExpressionCSV)  [function, functional]
  syntax Bool ::= isKResultExpressionList(ExpressionList)  [function, functional]
  syntax KResult
endmodule

module BASE-TYPES
  imports BASE-TYPES-SYNTAX

  rule isKResultExpression(_:Expression) => false [owise]
  rule isKResultExpression(_:Value) => true

  rule isKResult(E:Expression) => isKResultExpression(E)


  rule isKResultArgumentCSV(E:Expression , Es:ArgumentCSV)
      => isKResultExpression(E) andBool isKResultArgumentCSV(Es)
  rule isKResultArgumentCSV(E:Expression)
      => isKResultExpression(E)

  rule isKResult(Es:ArgumentCSV) => isKResultArgumentCSV(Es)


  rule isKResultExpressionCSV(.:ExpressionCSV) => true
  rule isKResultExpressionCSV(E:Expression , Es:ExpressionCSV) => isKResultExpression(E) andBool isKResultExpressionCSV(Es)

  rule isKResult(Es:ExpressionCSV) => isKResultExpressionCSV(Es)


  rule isKResultExpressionList([Es:ExpressionCSV]) => isKResultExpressionCSV(Es)
 
  rule isKResult(Es:ExpressionList) => isKResultExpressionList(Es)

endmodule
