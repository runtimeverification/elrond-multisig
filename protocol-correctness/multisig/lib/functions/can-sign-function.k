require "protocol-correctness/multisig/lib/language/syntax.k"

module CAN-SIGN-FUNCTION-SYNTAX
  imports BOOL
  imports MULTISIG-SYNTAX

  // TODO: Proof that this corresponds to canSign.
  syntax Bool ::= canSignFunction(UserRole)  [function, functional]
endmodule

module CAN-SIGN-FUNCTION
  imports CAN-SIGN-FUNCTION-SYNTAX
  imports K-EQUAL

  rule canSignFunction(Role:UserRole) => Role ==K BoardMember
endmodule

