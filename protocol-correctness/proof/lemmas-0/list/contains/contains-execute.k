require "protocol-correctness/proof/lemmas-0/lemmas-0-execute.k"
require "protocol-correctness/proof/lemmas-0/list/plistlen/trusted-lemma-plistlen.k"

module CONTAINS-EXECUTE-SYNTAX
  imports LEMMAS-0-EXECUTE-SYNTAX
endmodule

module CONTAINS-EXECUTE
  imports CONTAINS-EXECUTE-SYNTAX
  imports LEMMAS-0-EXECUTE

  imports TRUSTED-LEMMA-PLISTLEN
endmodule
