require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running-syntax.k"

module EXPRESSION-SYNTAX
  syntax Usize ::= add(Usize, Usize)  [function, functional]
  syntax Usize ::= sub(Usize, Usize)  [function, functional]
endmodule

module EXPRESSION
  imports BASE-TYPES-SYNTAX
  imports EXPRESSION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports RUNNING-SYNTAX

  rule add(u(A:Int), u(B:Int)) => u(A +Int B)
  rule sub(u(A:Int), u(B:Int)) => u(A -Int B)

  context evaluate(! {HOLE:Expression => evaluate(HOLE)}:>Expression)
  rule evaluate((! false) => true)
  rule evaluate((! true) => false)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression <= _:Expression)
  context evaluate(A:Expression <= {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) <= u(B:Int)) => (A <=Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression >= _:Expression)
  context evaluate(A:Expression >= {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) >= u(B:Int)) => (A <=Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression > _:Expression)
  context evaluate(A:Expression > {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) > u(B:Int)) => (A >Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression < _:Expression)
  context evaluate(A:Expression < {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) < u(B:Int)) => (A <Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression == _:Expression)
  context evaluate(A:Expression == {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Expression == B:Expression) => (A ==K B))
    requires isKResult(A) andBool isKResult(B)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression != _:Expression)
  context evaluate(A:Expression != {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Expression != B:Expression) => (A =/=K B))
    requires isKResult(A) andBool isKResult(B)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression &&  _:Expression)
  rule evaluate((E1:Expression && E2:Expression) => E2)
    requires isKResult(E1) andBool (E1 ==K true)
  rule evaluate((E1:Expression && _:Expression) => false)
    requires isKResult(E1) andBool (E1 ==K false)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression ||  _:Expression)
  rule evaluate((E1:Expression || _:Expression) => true)
    requires isKResult(E1) andBool (E1 ==K true)
  rule evaluate((E1:Expression || E2:Expression) => E2)
    requires isKResult(E1) andBool (E1 ==K false)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression + _:Expression)
  context evaluate(A:Expression + {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate(A:Usize + B:Usize => add(A, B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression - _:Expression)
  context evaluate(A:Expression - {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate(A:Usize - B:Usize => sub(A, B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression | _:Expression)
  context evaluate(A:Expression | {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) | u(B:Int)) => u(A |Int B))

  context evaluate([{HOLE:ExpressionCSV => evaluateEc(HOLE)}:>ExpressionCSV])
endmodule
