require "protocol-correctness/proof/lemmas/list/list-execute.k"
require "protocol-correctness/proof/lemmas/list/plistlen/trusted-lemma-plistlen.k"

module LAST-EXECUTE-SYNTAX
  imports LIST-EXECUTE-SYNTAX
endmodule

module LAST-EXECUTE
  imports LAST-EXECUTE-SYNTAX
  imports LIST-EXECUTE

  imports TRUSTED-LEMMA-PLISTLEN
endmodule
