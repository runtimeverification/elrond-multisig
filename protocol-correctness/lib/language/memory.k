require "protocol-correctness/lib/language/configuration.k"

module MEMORY
  imports LANGUAGE-CONFIGURATION

  context runInstruction(_:Variable = {HOLE => evaluate(HOLE)}:>Expression;)

  rule  <k> (runInstruction(V:Variable = E:Expression;) => evaluate(void)) ...</k>
        <variables> M:Map => M[V <- E] </variables>
    requires isKResult(E)

  context runInstruction(let _:Variable = {HOLE => evaluate(HOLE)}:>Expression;)

  rule  <k> (runInstruction(let V:Variable = E:Expression;) => evaluate(void)) ...</k>
        <variables> M:Map => M[V <- E] </variables>
    requires isKResult(E)

  rule  <k> evaluate(V:Variable => {M[V]}:>Expression) ... </k>
        <variables> M:Map </variables>
    requires V in_keys(M)
endmodule
