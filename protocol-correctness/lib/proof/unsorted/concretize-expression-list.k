require "protocol-correctness/lib/proof/unsorted/concretize-value.k"
require "protocol-correctness/lib/language/base-types.k"

module CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports INT

  // Splits the configuration into configurations where the list has
  // 0, 1, 2, ..., n-1 elements, or >= n elements. At the same time,
  // the first elements (up to n-1) are explicitly present in the list.
  //
  // This is useful when, e.g., one needs a recursive function on lists
  // to be evaluated a few times on a symbolic input.
  //
  // Example usage:
  //
  // Let's say that the user has a function define by
  //
  // syntax Int ::= listLen(ExpressionList)  [function, functional]
  // rule listLen([.]) => 0
  // rule listLen([E, Es]) => 1 +Int listLen(Es)
  //
  // Let's say that the following is the start configuration. Note that it
  // can't be simplified further.
  //
  // <k> concretizeExpressionList(L, 2) ~> doStuff(listLen(L)) <k>
  //
  // Resulting congurations before simplification:
  //
  // <k> doStuff(listLen([.])) <k> #And {L #Equals [.]}
  //
  // <k> doStuff(listLen([E1, .])) <k> #And {L #Equals [E1, .]}
  //
  // <k> doStuff(listLen([E1, E2, L1])) <k> #And {L #Equals [E1, E2, L1]}
  //
  // Resulting configurations after simplification:
  //
  // <k> doStuff(0) <k> #And {L #Equals [.]}
  //
  // <k> doStuff(1) <k> #And {L #Equals [E1, .]}
  //
  // <k> doStuff(2 + listLen([L1])) <k> #And {L #Equals [E1, E2, L1]}
  syntax KItem ::= concretizeExpressionList(ExpressionList, n:Int)
endmodule

module CONCRETIZE-EXPRESSION-LIST
  imports CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports CONCRETIZE-VALUE-SYNTAX

  rule concretizeExpressionList([.:ExpressionCSV], X:Int) => .K
    requires X >Int 0
    [label(concretizeListEmpty)]
  rule concretizeExpressionList([_:Expression , L:ExpressionCSV], X:Int)
      => concretizeExpressionList([L], X -Int 1)
    requires X >Int 0
    [label(concretizeListElement)]
  rule concretizeExpressionList([_:ExpressionCSV], X:Int)
      => .K
    requires X <=Int 0
    [label(concretizeListEnd)]
endmodule
