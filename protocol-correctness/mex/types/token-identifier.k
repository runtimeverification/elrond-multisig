require "protocol-correctness/lib/language/function-call.k"
require "protocol-correctness/lib/language/language.k"
require "protocol-correctness/mex/identifiers.k"

module TOKEN-IDENTIFIER-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Record ::= TokenIdentifier
  syntax TokenIdentifier ::= tokenIdentifier(BoxedBytes)
endmodule

module TOKEN-IDENTIFIER-ADDITIONAL-SYNTAX
  imports BOOL
  imports TOKEN-IDENTIFIER-SYNTAX

  syntax Bool ::= isValidEsdtIdentifier(TokenIdentifier) [function, functional, no-evaluators]
endmodule

module TOKEN-IDENTIFIER-TYPE-REFLECTION
    syntax ReflectionType ::= "rTokenIdentifier"
endmodule

module TOKEN-IDENTIFIER
  imports FUNCTION-CALL-SYNTAX
  imports MEX-IDENTIFIERS-SYNTAX
  imports TOKEN-IDENTIFIER-ADDITIONAL-SYNTAX
  imports TOKEN-IDENTIFIER-SYNTAX

  rule isKResultExpression(tokenIdentifier(B:BoxedBytes)) => isKResult(B)

  rule call(is_valid_esdt_identifier(Self:TokenIdentifier))
      => isValidEsdtIdentifier(Self)
endmodule
