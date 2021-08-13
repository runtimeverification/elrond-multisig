require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/configuration.k"
require "protocol-correctness/lib/language/flow.k"

module FUNCTION-CALL-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports STACK-SYNTAX

  syntax KItem ::= "pushContext" | "popContext" | "evaluateReturnValue" | "preCall"
  syntax KItem ::= call(Expression)
  syntax KItem ::= Expression

  syntax KItem ::= "getCustomStackState" | setCustomStackState(CustomStackState)
endmodule

module FUNCTION-CALL
  imports FLOW-SYNTAX
  imports FUNCTION-CALL-SYNTAX
  imports LANGUAGE-CONFIGURATION

  context evaluate(_:FunctionTag(
          {HOLE => evaluateAc(HOLE)}:>ArgumentCSV
      ))

  rule  evaluate(_:FunctionTag(Args:ArgumentCSV) #as FunctionCall)
        => (pushContext ~> preCall ~> call(FunctionCall) ~> popContext ~> evaluateReturnValue)
    requires isKResult(Args)
  rule  evaluate(_:FunctionTag() #as FunctionCall)
        => (pushContext ~> preCall ~> call(FunctionCall) ~> popContext ~> evaluateReturnValue)

  rule preCall => .K

  rule  (.K => getCustomStackState) ~> pushContext

  rule  <k> C:CustomStackState ~> pushContext => .K ... </k>
        <variables> V:Map => .Map </variables>
        <stack> Stack:Stack => stack(C, V, Stack) </stack>

  rule  <k> (evaluate(E:Expression) => E) ~> popContext ... </k>
    requires isKResult(E)

  rule  <k> E:Expression ~> (popContext => .K) ... </k>
        <variables> _ => V </variables>
        <stack> stack(_, V:Map, Stack:Stack) => Stack </stack>
    requires isKResult(E)

  rule  <k> (E:Expression ~> evaluateReturnValue) => evaluate(E) ... </k>
    requires isKResult(E)

  rule  <k> (.K => setCustomStackState(C)) ~> error ~> (popContext => .K) ...</k>
        <variables> _ => V </variables>
        <stack> stack(C:CustomStackState, V:Map, Stack:Stack) => Stack </stack>

  rule <k> error ~> (evaluateReturnValue => .K) ... </k>

  context runInstruction(ok({HOLE:Expression => evaluate(HOLE)}:>Expression);)
  rule runInstruction(ok(E:Expression);) => E requires isKResult(E)

endmodule
