require "protocol-correctness/lib/language/base-types.k"

module RUNNING-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= runExternalCalls(ExternalCommands)
  syntax KItem ::= runExternalCall(ExternalCommand)
  syntax KItem ::= runPseudoCode(Instructions)
  syntax KItem ::= runInstruction(Instruction)
  syntax KItem ::= evaluate(Expression)
  syntax KItem ::= evaluateEc(ExpressionCSV)
  syntax KItem ::= evaluateAc(ArgumentCSV)

  // TODO: Move to a better place.
  syntax KItem ::= "removeValue"
  syntax KItem ::= "nop"
endmodule
