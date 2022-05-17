require "protocol-correctness/lib/functions/list-elements-are-usize.k"
require "protocol-correctness/lib/language/base-types.k"

module MAP-VALUES-ARE-EXPRESSION-LIST-OF-USIZE-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapValuesAreExpressionListOfUsize(Map)  [function, functional]
endmodule

module MAP-VALUES-ARE-EXPRESSION-LIST-OF-USIZE
  imports MAP-VALUES-ARE-EXPRESSION-LIST-OF-USIZE-SYNTAX

  imports BASE-TYPES-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  rule mapValuesAreExpressionListOfUsize(.Map) => true
  rule mapValuesAreExpressionListOfUsize((_ |-> V M:Map) #as _:Map)
      =>  isExpressionList(V)
          andBool listElementsAreUsize(V)
          andBool mapValuesAreExpressionListOfUsize(M)
    [simplification]
endmodule

