require "protocol-correctness/multisig/lib/language/syntax.k"

module MULTISIG-CAST-SYNTAX
  imports MULTISIG-SYNTAX
  syntax UserRole ::= toUserRoleOrDefault(KItem, UserRole)  [function, functional]
endmodule

module MULTISIG-CAST
  imports MULTISIG-CAST-SYNTAX

  rule toUserRoleOrDefault(L:UserRole, _:UserRole) => L
  rule toUserRoleOrDefault(_:KItem, L:UserRole) => L  [owise]
endmodule