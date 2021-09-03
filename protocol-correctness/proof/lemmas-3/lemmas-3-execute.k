require "protocol-correctness/proof/lemmas-2/lemmas-2-execute.k"
require "protocol-correctness/proof/lemmas-3/lemmas-2.k"

module LEMMAS-3-EXECUTE-SYNTAX
  imports LEMMAS-2-EXECUTE-SYNTAX
endmodule

module LEMMAS-3-EXECUTE
  imports LEMMAS-2
  imports LEMMAS-2-EXECUTE
  imports LEMMAS-3-EXECUTE-SYNTAX
endmodule
