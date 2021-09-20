require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/functions/list-to-map-set.k"
require "protocol-correctness/multisig/lib/functions/at-most-this-signer-list.k"

module ONLY-THIS-SIGNER-DIFFS-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  // Note that this is asymmetrical: for the oldSigners it sometimes allows
  // other non-signing accounts besides signerId.
  // TODO: Make it symmetrical.
  syntax Bool ::= onlyThisSignerDiffs(
                      signerId:Usize,
                      oldSigners:Map,
                      newSigners:Map,
                      userIdToRole:Map
                  )  [function, functional]
endmodule

module ONLY-THIS-SIGNER-DIFFS
  imports AT-MOST-THIS-SIGNER-LIST-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports K-EQUAL
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports ONLY-THIS-SIGNER-DIFFS-SYNTAX


  syntax Bool ::= sameListElementsExceptOne(Expression, ExpressionList, ExpressionList)  [function, functional]
  rule sameListElementsExceptOne(E:Expression, First:ExpressionList, Second:ExpressionList)
      => listToMapSet(First)[E <- undef] ==K listToMapSet(Second)[E <- undef]

  rule onlyThisSignerDiffs(_:Usize, .Map, .Map, _:Map) => true

  rule onlyThisSignerDiffs
          ( A:Usize
          , (K |-> Old:ExpressionList OldSigners:Map)
          , (K |-> New:ExpressionList NewSigners:Map)
          , UserIdToRole:Map
          )
      => sameListElementsExceptOne(A, Old, New)
        andBool onlyThisSignerDiffs(A, OldSigners, NewSigners, UserIdToRole)
    [simplification]
  rule onlyThisSignerDiffs(
              A:Usize,
              (K |-> Old:ExpressionList OldSigners:Map),
              NewSigners:Map,
              UserIdToRole:Map)
      => atMostThisSignerList(A, Old, UserIdToRole)
        andBool onlyThisSignerDiffs(A, OldSigners, NewSigners, UserIdToRole)
    requires notBool K in_keys(NewSigners)
    [simplification]
  rule onlyThisSignerDiffs(
              A:Usize,
              OldSigners:Map,
              (K |-> New:ExpressionList NewSigners:Map),
              UserIdToRole:Map)
      => New ==K [A, .] andBool onlyThisSignerDiffs(A, OldSigners, NewSigners, UserIdToRole)
    requires notBool K in_keys(NewSigners)
    [simplification]

  // TODO: Proof
  rule onlyThisSignerDiffs(_:Usize, A:Map, A:Map, _:Map) => true  [simplification]
endmodule