require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module REFLECTION-MATCH
  imports BASE-TYPES-SYNTAX
  imports REFLECTION-SYNTAX

  rule matchPatternOrElse(., .:ExpressionCSV, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    [label(emptyListPattern)]
  rule matchPatternOrElse(., _:ExpressionCSV, _Matched:K, NotMatched:K)
      => NotMatched
    [label(notEmptyListPattern), priority(200)]

  rule matchPatternOrElse(
          A:ReflectionId <> B:ReflectionId,
          (E:Expression , Es:ExpressionCSV),
          Matched:K,
          _NotMatched:K)
      => (A, E) <> (B, Es) ~> Matched
    [label(elementAndListPattern)]
  rule matchPatternOrElse(
          _:ReflectionId <> _:ReflectionId,
          _:ExpressionCSV,
          _Matched:K,
          NotMatched:K)
      => NotMatched
    [label(notElementAndListPattern), priority(200)]

  rule matchPatternOrElse(True, true, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    [label(truePattern)]
  rule matchPatternOrElse(True, _:Bool, _Matched:K, NotMatched:K) => NotMatched
    [label(notTruePattern), priority(200)]

  rule matchPatternOrElse(False, false, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    [label(falsePattern)]
  rule matchPatternOrElse(False, _:Bool, _Matched:K, NotMatched:K) => NotMatched
    [label(notFalsePattern), priority(200)]

endmodule