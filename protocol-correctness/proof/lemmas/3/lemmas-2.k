require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-pound-list-swap-remove.k"
require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-pound-list-swap-remove-2.k"
require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-pound-remove-last.k"
require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-pound-remove-last-pound-last.k"
require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-remove-last.k"
require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-unsafe-element-last-to-start.k"
require "protocol-correctness/proof/lemmas/2/list/contains/trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-neq.k"
require "protocol-correctness/proof/lemmas/2/list/list-to-map-set/trusted-lemma-list-to-map-set-last-to-start.k"
require "protocol-correctness/proof/lemmas/2/list/plistlen/trusted-lemma-plistlen-last-to-start.k"
require "protocol-correctness/proof/lemmas/2/lemmas-1.k"

module LEMMAS-2
  imports LEMMAS-1

  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST-POUND-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-REMOVE-LAST
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-ELEMENT-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports TRUSTED-LEMMA-LIST-TO-MAP-SET-LAST-TO-START
  imports TRUSTED-LEMMA-PLISTLEN-LAST-TO-START
endmodule