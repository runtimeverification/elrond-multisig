require "protocol-correctness/proof/instrumentation-map.k"
require "protocol-correctness/proof/instrumentation-perform-split-action.k"

module INSTRUMENTATION-PERFORM-ACTION-SC-DEPLOY
  // TODO: Do I need this?
  imports INSTRUMENTATION-MAP

  imports INSTRUMENTATION-PERFORM-SPLIT-ACTION
  imports CONCRETIZE-VALUE-SYNTAX

  rule  <k> (splitting-action => concretizeValue(Arguments))
            ~> call(performAction(SCDeploy(
                        _Amount:BigUint,
                        _Code:BoxedBytes,
                        _CodeMetadata:CodeMetadata,
                        Arguments:ExpressionList)))
        ...</k>
    [priority(10)]

endmodule
