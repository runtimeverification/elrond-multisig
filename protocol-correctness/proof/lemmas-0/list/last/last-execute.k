require "protocol-correctness/proof/lemmas-0/lemmas-0-execute.k"
require "protocol-correctness/proof/lemmas-0/list/plistlen/trusted-lemma-plistlen.k"

module LAST-EXECUTE-SYNTAX
  imports LEMMAS-0-EXECUTE-SYNTAX
endmodule

module LAST-EXECUTE
  imports LAST-EXECUTE-SYNTAX
  imports LEMMAS-0-EXECUTE

  imports TRUSTED-LEMMA-PLISTLEN
endmodule
