require "protocol-correctness/lib/proof/induction/syntax.k"
require "protocol-correctness/proof/lemmas-0/list/contains/contains-execute.k"

require "protocol-correctness/proof/lemmas-0/list/contains/trusted-lemma-list-contains-pound-last.k"
require "protocol-correctness/proof/lemmas-0/list/contains/trusted-lemma-list-contains-remove-last-not-pound-last.k"

module USING-LEMMAS-EXECUTE-SYNTAX
  imports CONTAINS-EXECUTE-SYNTAX
endmodule

module USING-LEMMAS-EXECUTE
  imports USING-LEMMAS-EXECUTE-SYNTAX
  imports CONTAINS-EXECUTE

  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-REMOVE-LAST-NOT-POUND-LAST
endmodule
