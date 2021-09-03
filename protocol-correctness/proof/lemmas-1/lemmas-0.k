require "protocol-correctness/proof/lemmas-0/int/trusted-lemma-add-one-if-not-negative.k"
require "protocol-correctness/proof/lemmas-0/list/plistlen/trusted-lemma-plistlen.k"
require "protocol-correctness/proof/lemmas-0/map/all-keys-become-keys/trusted-lemma-all-keys-become-keys-a.k"
require "protocol-correctness/proof/lemmas-0/map/all-keys-become-keys/trusted-lemma-all-keys-become-keys-b.k"

module LEMMAS-0 
  imports TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE
  imports TRUSTED-LEMMA-ALL-KEYS-BECOME-KEYS-A
  imports TRUSTED-LEMMA-ALL-KEYS-BECOME-KEYS-B
  imports TRUSTED-LEMMA-PLISTLEN
endmodule