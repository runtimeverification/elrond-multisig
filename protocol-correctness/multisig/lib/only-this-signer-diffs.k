require "protocol-correctness/lib/language/base-types.k"

module ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= onlyThisSignerDiffs(signerId:Usize, oldSigners:Map, newSigners:Map)  [function, functional]
endmodule

module ONLY-THIS-SIGNER-DIFFS
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX

  syntax Map ::= listToMapSet(ExpressionList)  [function, functional]
  rule listToMapSet([.]) => .Map
  rule listToMapSet([E, Es]) => listToMapSet([Es])[E <- 0]

  syntax Bool ::= sameListElementsExceptOne(Expression, ExpressionList, ExpressionList)  [function, functional]
  rule sameListElementsExceptOne(E:Expression, First:ExpressionList, Second:ExpressionList)
      => listToMapSet(First)[E <- undef] ==K listToMapSet(Second)[E <- undef]

  rule onlyThisSignerDiffs(_:Usize, .Map, .Map) => true

  rule onlyThisSignerDiffs(A:Usize, (K |-> Old:ExpressionList OldSigners:Map), (K |-> New:ExpressionList NewSigners:Map))
      => sameListElementsExceptOne(A, Old, New) andBool onlyThisSignerDiffs(A, OldSigners, NewSigners)
    [simplification]
  rule onlyThisSignerDiffs(A:Usize, (K |-> Old:ExpressionList OldSigners:Map), NewSigners:Map)
      => Old ==K [A, .] andBool onlyThisSignerDiffs(A, OldSigners, NewSigners)
    requires notBool K in_keys(NewSigners)
    [simplification]
  rule onlyThisSignerDiffs(A:Usize, OldSigners:Map, (K |-> New:ExpressionList NewSigners:Map))
      => New ==K [A, .] andBool onlyThisSignerDiffs(A, OldSigners, NewSigners)
    requires notBool K in_keys(NewSigners)
    [simplification]

  // TODO: Proof
  rule onlyThisSignerDiffs(_:Usize, A:Map, A:Map) => true  [simplification]
endmodule