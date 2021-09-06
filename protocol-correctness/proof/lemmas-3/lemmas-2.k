require "protocol-correctness/proof/lemmas-2/list/contains/trusted-lemma-list-contains-pound-list-swap-remove.k"
require "protocol-correctness/proof/lemmas-2/list/contains/trusted-lemma-list-contains-pound-list-swap-remove-2.k"
require "protocol-correctness/proof/lemmas-2/list/contains/trusted-lemma-list-contains-pound-remove-last.k"
require "protocol-correctness/proof/lemmas-2/list/contains/trusted-lemma-list-contains-pound-remove-last-pound-last.k"
require "protocol-correctness/proof/lemmas-2/list/contains/trusted-lemma-list-contains-remove-last.k"
require "protocol-correctness/proof/lemmas-2/list/plistlen/trusted-lemma-plistlen-last-to-start.k"
require "protocol-correctness/proof/lemmas-2/lemmas-1.k"

module LEMMAS-2
  imports LEMMAS-1

  imports TRUSTED-LEMMA-PLISTLEN-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST-POUND-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-REMOVE-LAST
endmodule