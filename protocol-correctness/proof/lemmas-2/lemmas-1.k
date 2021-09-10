require "protocol-correctness/proof/lemmas-1/lemmas-0.k"
require "protocol-correctness/proof/lemmas-1/list/contains/trusted-lemma-list-contains-last-to-start.k"
require "protocol-correctness/proof/lemmas-1/list/contains/trusted-lemma-list-contains-pound-last.k"
require "protocol-correctness/proof/lemmas-1/list/contains/trusted-lemma-list-contains-remove-last-not-pound-last.k"
require "protocol-correctness/proof/lemmas-1/list/list-to-map-set/trusted-lemma-list-to-map-set-pound-remove-last-pound-last.k"
require "protocol-correctness/proof/lemmas-1/list/plistlen/trusted-lemma-plistlen-remove-last.k"
require "protocol-correctness/proof/lemmas-1/map/square-bracket/trusted-lemma-square-bracket-sq-b-sq-b-undef.k"

module LEMMAS-1
  imports LEMMAS-0

  imports TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
  imports TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST
  imports TRUSTED-LEMMA-LIST-TO-MAP-SET-POUND-REMOVE-LAST-POUND-LAST
  imports TRUSTED-LEMMA-PLISTLEN-REMOVE-LAST
  imports TRUSTED-LEMMA-SQUARE-BRACKET-SQ-B-SQ-B-UNDEF

endmodule