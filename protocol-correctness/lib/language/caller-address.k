require "protocol-correctness/lib/language/base-types.k"

module CALLER-ADDRESS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax CallerAddress ::= "uninitialized" | Address
endmodule
