require "protocol-correctness/proof/lemmas/1/lemmas-1-execute.k"
require "protocol-correctness/proof/lemmas/2/lemmas-1.k"

module LEMMAS-2-EXECUTE-SYNTAX
  imports LEMMAS-1-EXECUTE-SYNTAX
endmodule

module LEMMAS-2-EXECUTE
  imports LEMMAS-1
  imports LEMMAS-1-EXECUTE
  imports LEMMAS-2-EXECUTE-SYNTAX
endmodule
