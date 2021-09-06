require "protocol-correctness/proof/lemmas-1/list/contains/trusted-lemma-list-contains-last-to-start.k"
require "protocol-correctness/proof/lemmas-1/list/contains/trusted-lemma-list-contains-pound-last.k"
require "protocol-correctness/proof/lemmas-1/list/contains/trusted-lemma-list-contains-remove-last-not-pound-last.k"
require "protocol-correctness/proof/lemmas-1/list/plistlen/trusted-lemma-plistlen-remove-last.k"
require "protocol-correctness/proof/lemmas-1/lemmas-0.k"

module LEMMAS-1
  imports LEMMAS-0

  imports TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST
  imports TRUSTED-LEMMA-PLISTLEN-REMOVE-LAST

endmodule