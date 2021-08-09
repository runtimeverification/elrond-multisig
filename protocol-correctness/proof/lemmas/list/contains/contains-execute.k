require "protocol-correctness/proof/lemmas/lemmas-execute.k"
require "protocol-correctness/proof/lemmas/list/plistlen/trusted-lemma-plistlen.k"

module CONTAINS-EXECUTE-SYNTAX
  imports LEMMAS-EXECUTE-SYNTAX
endmodule

module CONTAINS-EXECUTE
  imports CONTAINS-EXECUTE-SYNTAX
  imports LEMMAS-EXECUTE

  imports TRUSTED-LEMMA-PLISTLEN
endmodule
