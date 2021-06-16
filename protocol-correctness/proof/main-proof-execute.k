require "protocol-correctness/proof/lemmas.k"
require "protocol-correctness/proof/main-proof-execute-no-lemmas.k"

module MAIN-PROOF-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-NO-LEMMAS-SYNTAX
endmodule

module MAIN-PROOF-EXECUTE
  imports MAIN-PROOF-EXECUTE-NO-LEMMAS

  imports LEMMAS
endmodule
