module STACK-SYNTAX
  imports MAP

  syntax CustomStackState

  syntax Stack ::= ".stack"
  syntax Stack ::= stack(CustomStackState, variables:Map, next:Stack)
endmodule
