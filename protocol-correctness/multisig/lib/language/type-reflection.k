require "protocol-correctness/lib/language/flow.k"
require "protocol-correctness/lib/language/type-reflection.k"
require "protocol-correctness/multisig/lib/language/syntax.k"

module MULTISIG-TYPE-REFLECTION-SYNTAX
  syntax ReflectionType ::= "rUserRole"
                        |   "rAction"
                        |   "rCodeMetadata"
endmodule

module MULTISIG-TYPE-REFLECTION
  imports MULTISIG-TYPE-REFLECTION-SYNTAX

  imports FLOW-SYNTAX
  imports MULTISIG-SYNTAX
  imports TYPE-REFLECTION-SYNTAX

  rule cast(U:UserRole, rUserRole) => U  [label(castUserRole)]
  rule (.K => stuck) ~> cast(V:KItem, rUserRole)
    ensures notBool isUserRole(V)
    [owise, label(castUserRoleStuck)]

  rule cast(A:Action, rAction) => A  [label(castAction)]
  rule (.K => stuck) ~> cast(V:KItem, rAction)
    ensures notBool isAction(V)
    [owise, label(castActionStuck)]

  rule defaultValue(rUserRole) => None
  rule defaultValue(rAction) => Nothing
  rule defaultValue(rCodeMetadata) => CodeMetadata::DEFAULT

  rule valueOfType(V:KItem, rUserRole) => isUserRole(V)
  rule valueOfType(V:KItem, rAction) => isAction(V)
  rule valueOfType(V:KItem, rCodeMetadata) => isCodeMetadata(V)
endmodule

