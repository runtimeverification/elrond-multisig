require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/map-utils.k"
require "protocol-correctness/lib/language/reflection.k"

module REFLECTION-MATCH
  imports REFLECTION-MATCH-BOOL
  imports REFLECTION-MATCH-EQUALITY
  imports REFLECTION-MATCH-EXPRESSION-CSV
  imports REFLECTION-MATCH-INT
  imports REFLECTION-MATCH-MAP
endmodule

module REFLECTION-MATCH-EXPRESSION-CSV
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
endmodule

module REFLECTION-MATCH-MAP
  imports BOOL
  imports K-EQUAL-SYNTAX
  imports MAP
  imports MAP-UTILS-SYNTAX
  imports REFLECTION-SYNTAX

  rule matchPatternOrElse(., reflectionKey(M:Map, K:KItem), Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
      requires notBool K in_keys(M)
    [label(keyNotInMapPattern)]
  rule matchPatternOrElse(., reflectionKey(M:Map, K:KItem), _Matched:K, NotMatched:K)
      => NotMatched
      requires K in_keys(M)
    [label(notKeyNotInMapPattern), priority(200)]

  rule matchPatternOrElse(
          A:ReflectionId[B:ReflectionId <- C:ReflectionId],
          reflectionKey(M:Map, K:KItem),
          Matched:K,
          _NotMatched:K)
      =>  concretizeMapKey(K, M)
          ~> (A, M[K <- undef]) <> (B, K) <> (C, M[K])
          ~> Matched
      requires K in_keys(M)
    [label(keyInMapPattern)]
  rule matchPatternOrElse(
          _:ReflectionId[_:ReflectionId <- _:ReflectionId],
          reflectionKey(M:Map, K:KItem),
          _Matched:K,
          NotMatched:K)
      => NotMatched
      requires notBool K in_keys(M)
    [label(notKeyInMapPattern), priority(200)]


  rule matchPatternOrElse(., .Map, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    [label(emptyMapPattern)]
  rule matchPatternOrElse(., M:Map, _Matched:K, NotMatched:K)
      => NotMatched
      requires M =/=K .Map
    [label(notEmptyMapPattern), priority(200)]

  rule matchPatternOrElse(
          A:ReflectionId[B:ReflectionId <- C:ReflectionId],
          K:KItem|-> V:KItem M:Map,
          Matched:K,
          _NotMatched:K)
      =>  (A, M) <> (B, K) <> (C, V)
          ~> Matched
    [label(nonEmptyMapPattern)]
  rule matchPatternOrElse(
          _:ReflectionId[_:ReflectionId <- _:ReflectionId],
          M:Map,
          _Matched:K,
          NotMatched:K)
      => NotMatched
      // TODO: Remove this when the Haskell backend will handle map case
      // matching properly.
      ensures M ==K .Map
    [label(notNonEmptyMapPattern), priority(200)]
endmodule

module REFLECTION-MATCH-BOOL
  imports BASE-TYPES-SYNTAX
  imports REFLECTION-SYNTAX

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

module REFLECTION-MATCH-EQUALITY
  imports BASE-TYPES-SYNTAX
  imports REFLECTION-SYNTAX

  rule matchPatternOrElse(= K1:KItem, K1:KItem, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    [label(equalPattern)]
  rule matchPatternOrElse(= _:KItem, _:KItem, _Matched:K, NotMatched:K) => NotMatched
    [label(notEqualPattern), priority(200)]
endmodule

module REFLECTION-MATCH-INT
  imports BASE-TYPES-SYNTAX
  imports REFLECTION-SYNTAX

  rule matchPatternOrElse(< I1:Int, I2:Int, Matched:K, _NotMatched:K)  // >
      => .ReflectionData ~> Matched
    requires I2 <Int I1
    [label(lessPattern)]
  rule matchPatternOrElse(< _:Int, _:Int, _Matched:K, NotMatched:K) => NotMatched
    [label(notLessPattern), priority(200)]

  rule matchPatternOrElse(<= I1:Int, I2:Int, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    requires I2 <=Int I1
    [label(lessEqPattern)]
  rule matchPatternOrElse(<= _:Int, _:Int, _Matched:K, NotMatched:K) => NotMatched
    [label(notLessEqPattern), priority(200)]

  rule matchPatternOrElse(> I1:Int, I2:Int, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    requires I2 >Int I1
    [label(greaterPattern)]
  rule matchPatternOrElse(> _:Int, _:Int, _Matched:K, NotMatched:K) => NotMatched
    [label(notGreaterPattern), priority(200)]

  rule matchPatternOrElse(>= I1:Int, I2:Int, Matched:K, _NotMatched:K)
      => .ReflectionData ~> Matched
    requires I2 >=Int I1
    [label(greaterEqPattern)]
  rule matchPatternOrElse(>= _:Int, _:Int, _Matched:K, NotMatched:K) => NotMatched
    [label(notGreaterEqPattern), priority(200)]
endmodule
