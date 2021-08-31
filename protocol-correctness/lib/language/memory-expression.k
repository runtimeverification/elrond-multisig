require "protocol-correctness/lib/language/configuration.k"

module MEMORY-EXPRESSION
  imports LANGUAGE-CONFIGURATION

  rule runInstruction((V:Variable += E:Expression;) => (V = V + E;))
endmodule
