require "protocol-correctness/proof/lemmas/5/lemmas-5-execute.k"
require "protocol-correctness/proof/lemmas/lemmas.k"

module LEMMAS-EXECUTE-SYNTAX
  imports LEMMAS-5-EXECUTE-SYNTAX
endmodule

module LEMMAS-EXECUTE
  imports LEMMAS-4
  imports LEMMAS-5-EXECUTE
  imports LEMMAS-EXECUTE-SYNTAX
endmodule
