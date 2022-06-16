require "protocol-correctness/proof/main-proof-execute.k"

module LEMMAS-0-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-SYNTAX
  imports K-EQUAL-SYNTAX

endmodule

module LEMMAS-0-EXECUTE
  imports MAIN-PROOF-EXECUTE

  imports LEMMAS-0-EXECUTE-SYNTAX
endmodule
