require "protocol-correctness/proof/main-proof-execute-no-lemmas.k"

module LEMMAS-0-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-NO-LEMMAS-SYNTAX
  imports K-EQUAL

endmodule

module LEMMAS-0-EXECUTE
  imports MAIN-PROOF-EXECUTE-NO-LEMMAS

  imports LEMMAS-0-EXECUTE-SYNTAX
endmodule
