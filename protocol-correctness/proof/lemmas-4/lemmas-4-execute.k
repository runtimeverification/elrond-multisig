require "protocol-correctness/proof/lemmas-3/lemmas-3-execute.k"
require "protocol-correctness/proof/lemmas-4/lemmas-3.k"

module LEMMAS-4-EXECUTE-SYNTAX
  imports LEMMAS-3-EXECUTE-SYNTAX
endmodule

module LEMMAS-4-EXECUTE
  imports LEMMAS-3
  imports LEMMAS-3-EXECUTE
  imports LEMMAS-4-EXECUTE-SYNTAX
endmodule
