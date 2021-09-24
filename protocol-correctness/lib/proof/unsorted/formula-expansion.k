module FORMULA-EXPANSION-SYNTAX
  // Expand and PropertyHandling form a stupid trick used to control symbolic
  // function application.
  // Any function that receives them as an argument should not depend on them,
  // i.e it should have the same value for all possible PropertyHandling values.
  // TODO: Prove lemmas about this.
  syntax Expand ::= "expanded" | expand(Expand)
  syntax PropertyHandling ::= "usesExpanded" | Expand
  // TODO: Delete above or below.
  // syntax Int ::= expand(Int)  [function, functional, no-evaluators]
  // syntax Int ::= "usesExpanded"  [function, functional, no-evaluators]

endmodule