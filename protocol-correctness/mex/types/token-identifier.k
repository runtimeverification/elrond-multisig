require "protocol-correctness/lib/language/language.k"

module TOKEN-IDENTIFIER-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Record ::= TokenIdentifier
  syntax TokenIdentifier ::= tokenIdentifier(BoxedBytes)
endmodule
