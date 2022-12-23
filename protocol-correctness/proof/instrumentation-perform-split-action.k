require "protocol-correctness/pseudocode.k"
require "protocol-correctness/proof/instrumentation-concretize.k"

module INSTRUMENTATION-PERFORM-SPLIT-ACTION
  imports PSEUDOCODE
  imports INSTRUMENTATION-CONCRETIZE
  imports CONCRETIZE-VALUE-SYNTAX

  syntax KItem ::= "splitting-action"
  rule  <k> pushContext ~> (.K => splitAction(A) ~> splitting-action) ~> call(performAction(A:Action))
        ...</k>
    [priority(10)]
  rule  <k> (splitting-action => .K) ...</k>
    [priority(20)]

  syntax KItem ::= splitAction(Action)
  rule splitAction(Nothing) => .K
  rule splitAction(AddBoardMember(A:Address)) => concretizeValue(A)
  rule splitAction(AddProposer(A:Address)) => concretizeValue(A)
  rule splitAction(RemoveUser(A:Address)) => concretizeValue(A)
  rule splitAction(ChangeQuorum(Q:Usize)) => concretizeValue(Q)
  rule splitAction(SendEgld(To:Address, Amount:BigUint, Data:BoxedBytes)) =>
      concretizeValue(To) ~> concretizeValue(Amount) ~> concretizeValue(Data)
  rule splitAction(SCDeploy(
          Amount:BigUint,
          Code:BoxedBytes,
          CodeMetadata:CodeMetadata,
          Arguments:ExpressionList))
      =>   concretizeValue(Amount)
        ~> concretizeValue(Code)
        ~> concretizeValue(CodeMetadata)
        ~> concretizeValue(Arguments)
  rule splitAction(SCCall(
          To:Address,
          Amount:BigUint,
          Function:BoxedBytes,
          Arguments:ExpressionList))
      =>   concretizeValue(To)
        ~> concretizeValue(Amount)
        ~> concretizeValue(Function)
        ~> concretizeValue(Arguments)

endmodule
