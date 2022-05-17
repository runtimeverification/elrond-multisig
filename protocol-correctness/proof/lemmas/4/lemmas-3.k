require "protocol-correctness/proof/lemmas/3/list/contains/trusted-lemma-list-contains-pound-last-pound-remove-last.k"
require "protocol-correctness/proof/lemmas/3/list/contains/trusted-lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq.k"
require "protocol-correctness/proof/lemmas/3/list/list-to-map-set/trusted-lemma-list-to-map-set-list-swap-remove-list-find-delete.k"
require "protocol-correctness/proof/lemmas/3/list/plistlen/trusted-lemma-plistlen-list-swap-remove-list-find.k"
require "protocol-correctness/proof/lemmas/3/lemmas-2.k"

module LEMMAS-3
  imports LEMMAS-2

  imports TRUSTED-LEMMA-PLISTLEN-LIST-SWAP-REMOVE-LIST-FIND
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST-POUND-REMOVE-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-1-ELEMENT-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports TRUSTED-LEMMA-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-DELETE
endmodule