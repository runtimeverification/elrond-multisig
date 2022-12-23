require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/multisig/lib/language/syntax.k"

module CAN-SIGN-FUNCTION-SYNTAX
  imports BOOL
  imports MULTISIG-SYNTAX

  // TODO: Proof that this corresponds to canSign.
  syntax Bool ::= canSignFunction(UserRole)  [function, functional]
endmodule

module CAN-SIGN-FUNCTION
  imports CAN-SIGN-FUNCTION-SYNTAX
  imports CAN-SIGN-FUNCTION-REFLECTION
  imports K-EQUAL-SYNTAX

  rule canSignFunction(Role:UserRole) => Role ==K BoardMember
endmodule

module CAN-SIGN-FUNCTION-REFLECTION
  imports CAN-SIGN-FUNCTION-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply
          ( $canSignFunction
          , reflectionArgument(Role:UserRole)
          )
      => canSignFunction(Role)
endmodule
