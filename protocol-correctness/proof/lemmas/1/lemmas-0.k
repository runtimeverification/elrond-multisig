require "protocol-correctness/proof/lemmas/0/bool/trusted-lemma-bool-to-int-ge-0.k"
require "protocol-correctness/proof/lemmas/0/bool/trusted-lemma-bool-to-int-le-1.k"
require "protocol-correctness/proof/lemmas/0/int/trusted-lemma-add-one-if-not-negative.k"
require "protocol-correctness/proof/lemmas/0/int/trusted-lemma-add-one-if-not-negative-not-zero.k"
require "protocol-correctness/proof/lemmas/0/list/plistlen/trusted-lemma-plistlen.k"
require "protocol-correctness/proof/lemmas/0/map/all-keys-become-keys/trusted-lemma-all-keys-become-keys-a.k"
require "protocol-correctness/proof/lemmas/0/map/all-keys-become-keys/trusted-lemma-all-keys-become-keys-b.k"
require "protocol-correctness/proof/lemmas/0/map/square-bracket/trusted-lemma-square-bracket-square-bracket-undef.k"
require "protocol-correctness/proof/lemmas/0/signers/trusted-lemma-at-most-this-signer-0-count-can-sign-function.k"

module LEMMAS-0
  imports TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE
  imports TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE-NOT-ZERO
  imports TRUSTED-LEMMA-ALL-KEYS-BECOME-KEYS-A
  imports TRUSTED-LEMMA-ALL-KEYS-BECOME-KEYS-B
  imports TRUSTED-LEMMA-AT-MOST-THIS-SIGNER-0-COUNT-CAN-SIGN-FUNCTION
  imports TRUSTED-LEMMA-BOOL-TO-INT-GE-0
  imports TRUSTED-LEMMA-BOOL-TO-INT-LE-1
  imports TRUSTED-LEMMA-SQUARE-BRACKET-SQUARE-BRACKET-UNDEF
  imports TRUSTED-LEMMA-PLISTLEN
endmodule
