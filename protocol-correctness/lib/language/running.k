require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/configuration.k"
require "protocol-correctness/lib/language/flow.k"
require "protocol-correctness/lib/language/running-syntax.k"

module RUNNING
  imports RUNNING-EXTERNAL
  imports RUNNING-INSTRUCTIONS
  imports RUNNING-INSTRUMENTATION
endmodule

module RUNNING-EXTERNAL
  imports FLOW-SYNTAX
  imports LANGUAGE-CONFIGURATION
  imports RUNNING-SYNTAX

  rule runExternalCalls(C:ExternalCommand) => runExternalCall(C)
  rule runExternalCalls(C:ExternalCommand Cs:ExternalCommands)
      => runExternalCall(C) ~> runExternalCalls(Cs)

  syntax KItem ::= "clearExternalCallEnv"
  rule  <k> clearExternalCallEnv => .K ... </k>
        <caller-address> _ => uninitialized </caller-address>

  rule (evaluate(E:Expression) => .K) ~> clearExternalCallEnv
    requires isKResult(E)
    [label(removeEvaluateBeforeClearExternalCallEnv)]

  rule (E:Expression => .K) ~> clearExternalCallEnv
    requires isKResult(E)

  rule  <k> (error => .K) ~> clearExternalCallEnv ...</k>

  syntax KItem ::= endpointToInstruction(EndpointCall)
  rule endpointToInstruction(Tag:EndpointTag()) => runInstruction(Tag();)
  rule endpointToInstruction(Tag:EndpointTag(Es:ArgumentCSV)) => runInstruction(Tag(Es);)

  rule  <k>
            runExternalCall(from A:Address run Call:EndpointCall;)
            => endpointToInstruction(Call) ~> clearExternalCallEnv
        ...</k>
        <caller-address> uninitialized => A </caller-address>

  rule nop => .K
endmodule

module RUNNING-INSTRUCTIONS
  imports FLOW-SYNTAX
  imports RUNNING-SYNTAX
  imports LANGUAGE-CONFIGURATION

  rule runPseudoCode(I:Instruction) => runInstruction(I)
  rule runPseudoCode(I:Instruction Is:Instructions)
      => runInstruction(I) ~> runPseudoCode(Is)

  rule  <k> error ~> (runPseudoCode(_) => .K) ...</k>
  rule  <k> error => .K </k>
        <stack> .stack </stack>

  rule runInstruction(E:Expression;) => evaluate(E)
  rule (evaluate(E:Expression) => .K) ~> runInstruction(_)
    requires isKResult(E)
  rule (evaluate(E:Expression) => .K) ~> runPseudoCode(_)
    requires isKResult(E)

  context runInstruction(require({HOLE:Expression => evaluate(HOLE)}:>Expression);)
  rule runInstruction(require(true);) => evaluate(void)  [label(requireTrue)]
  rule runInstruction(require(false);) => error  [label(requireError)]
endmodule

module RUNNING-INSTRUMENTATION
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX

  rule (E:Expression ~> removeValue) => .K
    requires isKResult(E)
endmodule
