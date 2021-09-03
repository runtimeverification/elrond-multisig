require "protocol-correctness/proof/main-proof-execute-no-lemmas.k"

module LEMMAS-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-NO-LEMMAS-SYNTAX
  imports K-EQUAL

endmodule

module LEMMAS-EXECUTE
  imports MAIN-PROOF-EXECUTE-NO-LEMMAS

  imports LEMMAS-EXECUTE-SYNTAX
endmodule
