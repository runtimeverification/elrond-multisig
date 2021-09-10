require "protocol-correctness/proof/lemmas-5/lemmas-5-execute.k"
require "protocol-correctness/proof/lemmas-final/lemmas-final.k"

module LEMMAS-FINAL-EXECUTE-SYNTAX
  imports LEMMAS-5-EXECUTE-SYNTAX
endmodule

module LEMMAS-FINAL-EXECUTE
  imports LEMMAS-4
  imports LEMMAS-5-EXECUTE
  imports LEMMAS-FINAL-EXECUTE-SYNTAX
endmodule
