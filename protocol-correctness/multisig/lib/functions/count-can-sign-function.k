require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/multisig/lib/functions/can-sign-function.k"
require "protocol-correctness/multisig/lib/language/syntax.k"

module COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports INT
  imports MAP

  syntax Int ::= countCanSignFunction(signerIDs:ExpressionList, userIdToRole:Map)  [function, functional, smtlib(countCanSignFunction)]
endmodule

module COUNT-CAN-SIGN-FUNCTION
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX

  imports CAN-SIGN-FUNCTION-SYNTAX
  imports MULTISIG-SYNTAX

  rule countCanSignFunction([.], _:Map) => 0
  rule countCanSignFunction([UserId:Usize, Es:ExpressionCSV], UserId |-> Role:UserRole M:Map)
      => 1 +Int countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires canSignFunction(Role)
    ensures notBool UserId in_keys(M)
  rule countCanSignFunction([UserId:Usize, Es:ExpressionCSV], UserId |-> Role:UserRole M:Map)
      => countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires notBool canSignFunction(Role)
    ensures notBool UserId in_keys(M)
  rule countCanSignFunction([UserId:Usize, Es:ExpressionCSV], M:Map)
      => countCanSignFunction([Es], M)
    requires notBool UserId in_keys(M)
  rule countCanSignFunction([_:Expression, Es:ExpressionCSV], M)
      => countCanSignFunction([Es], M)
    [owise]
endmodule

