module BASE
  imports EXPLICIT-KITEM-INJECTION
endmodule

module EXPLICIT-KITEM-INJECTION
  syntax KItem
  // The Haskell backend does not send sort injections to the SMT solver.
  // However, sometimes, in predicates one needs to use KItems that should be
  // sent to the SMT solver. ExplicitKItem allows us to do that.
  syntax ExplicitKItem ::= wrap(KItem)
endmodule
