require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running.k"

module RECORD
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX

  rule evaluate(E:Expression . F:FunctionTag()) => evaluate(F(E))
  rule evaluate(E:Expression . F:FunctionTag(A:ArgumentCSV)) => evaluate(F(E, A))
endmodule
