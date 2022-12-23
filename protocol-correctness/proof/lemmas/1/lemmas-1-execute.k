require "protocol-correctness/proof/lemmas/0/lemmas-0-execute.k"
require "protocol-correctness/proof/lemmas/1/lemmas-0.k"

module LEMMAS-1-EXECUTE-SYNTAX
  imports LEMMAS-0-EXECUTE-SYNTAX

endmodule

module LEMMAS-1-EXECUTE
  imports LEMMAS-0
  imports LEMMAS-0-EXECUTE
  imports LEMMAS-1-EXECUTE-SYNTAX
endmodule
