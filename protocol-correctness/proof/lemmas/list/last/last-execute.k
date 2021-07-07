require "protocol-correctness/proof/lemmas/lemmas-execute.k"
require "protocol-correctness/proof/lemmas/list/plistlen/trusted-lemma-plistlen.k"

module LAST-EXECUTE-SYNTAX
  imports LEMMAS-EXECUTE-SYNTAX
endmodule

module LAST-EXECUTE
  imports LAST-EXECUTE-SYNTAX
  imports LEMMAS-EXECUTE

  imports TRUSTED-LEMMA-PLISTLEN
endmodule
