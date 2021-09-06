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


  rule matchPatternOrElse(= K1:KItem, K1:KItem, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    [label(equalPattern)]
  rule matchPatternOrElse(= _:KItem, _:KItem, _Matched:K, NotMatched:K) => NotMatched
    [label(notEqualPattern), priority(200)]


  rule matchPatternOrElse(< I1:Int, I2:Int, Matched:K, _NotMatched:K)  // >
      => .ReflectionData ~> Matched
    requires I2 <Int I1
    [label(lessPattern)]
  rule matchPatternOrElse(< _:Int, _:Int, _Matched:K, NotMatched:K) => NotMatched
    [label(notLessPattern), priority(200)]

  rule matchPatternOrElse(> I1:Int, I2:Int, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    requires I2 >Int I1
    [label(greaterPattern)]
  rule matchPatternOrElse(> _:Int, _:Int, _Matched:K, NotMatched:K) => NotMatched
    [label(notGreaterPattern), priority(200)]

endmodule