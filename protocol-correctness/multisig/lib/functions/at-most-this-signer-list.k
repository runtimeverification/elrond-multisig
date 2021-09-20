require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/multisig/lib/functions/can-sign-function.k"
require "protocol-correctness/multisig/lib/language/cast.k"

module AT-MOST-THIS-SIGNER-LIST-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= atMostThisSignerList(signerId:Usize, signatures:ExpressionList, userRoles:Map)  [function]
endmodule

module AT-MOST-THIS-SIGNER-LIST-ADDITIONAL-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= #atMostThisSignerList(signerId:Usize, signatures:ExpressionList, userRoles:Map)  [function, functional]
endmodule

module AT-MOST-THIS-SIGNER-LIST
  imports AT-MOST-THIS-SIGNER-LIST-SYNTAX
  imports AT-MOST-THIS-SIGNER-LIST-ADDITIONAL-SYNTAX
  imports CAN-SIGN-FUNCTION-SYNTAX
  imports K-EQUAL
  imports MAP
  imports MULTISIG-CAST-SYNTAX

  rule atMostThisSignerList(SignerId:Usize, Signers:ExpressionList, UserIdToRole:Map)
      => #atMostThisSignerList(SignerId, Signers, UserIdToRole)
    requires isKResult(Signers)

  rule #atMostThisSignerList(_SignerId:Usize, [.], _UserIdToRole:Map) => true
  rule #atMostThisSignerList(
          SignerId:Usize,
          [(SignerId, Es:ExpressionCSV) => Es],
          _:Map)
  rule #atMostThisSignerList(
          SignerId:Usize,
          [OtherId:Expression, Es:ExpressionCSV],
          UserIdToRole:Map)
      => #atMostThisSignerList(SignerId, [Es], UserIdToRole)
    requires SignerId =/=K OtherId
      andBool notBool OtherId in_keys(UserIdToRole)
  rule #atMostThisSignerList(
          SignerId:Usize,
          [OtherId, Es:ExpressionCSV],
          UserIdToRole:Map)
      => #atMostThisSignerList(SignerId, [Es], UserIdToRole)
    requires SignerId =/=K OtherId
      andBool OtherId in_keys(UserIdToRole)
      andBool notBool canSignFunction(
            toUserRoleOrDefault(UserIdToRole[OtherId] orDefault BoardMember, BoardMember))
  rule #atMostThisSignerList(_SignerId:Usize, _Signers:ExpressionList, _UserIdToRole:Map)
      => false
    [owise]

endmodule

