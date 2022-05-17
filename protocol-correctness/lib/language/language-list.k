require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running-syntax.k"

module LANGUAGE-LIST
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX

  context evaluateAc({HOLE:Expression => evaluate(HOLE)}:>ArgumentCSV)
  context evaluateAc({HOLE:Expression => evaluate(HOLE)}:>Expression , _:ArgumentCSV)
  context evaluateAc(E:Expression , {HOLE:ArgumentCSV => evaluateAc(HOLE)}:>ArgumentCSV)
    requires isKResult(E)

  context evaluateEc({HOLE:Expression => evaluate(HOLE)}:>Expression , _:ExpressionCSV)
  context evaluateEc(E:Expression , {HOLE:ExpressionCSV => evaluateEc(HOLE)}:>ExpressionCSV)
    requires isKResult(E)

endmodule
