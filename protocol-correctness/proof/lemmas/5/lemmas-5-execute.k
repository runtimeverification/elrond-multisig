require "protocol-correctness/proof/lemmas/4/lemmas-4-execute.k"
require "protocol-correctness/proof/lemmas/5/lemmas-4.k"

module LEMMAS-5-EXECUTE-SYNTAX
  imports LEMMAS-4-EXECUTE-SYNTAX
endmodule

module LEMMAS-5-EXECUTE
  imports LEMMAS-4
  imports LEMMAS-4-EXECUTE
  imports LEMMAS-5-EXECUTE-SYNTAX
endmodule
