require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-last.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-last-usize.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-last-to-start-kresult.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-last-to-start-usize.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-last.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-last-expression.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-last-usize.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-last-usize-kitem.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-remove-last-kresult.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-remove-last-kresult-expression.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-pound-remove-last-usize.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-remove-last-kresult.k"
require "protocol-correctness/proof/lemmas-0/list/last/trusted-lemma-remove-last-usize.k"

require "protocol-correctness/proof/lemmas-4/lemmas-3.k"

module LEMMAS
  imports TRUSTED-LEMMA-LAST
  imports TRUSTED-LEMMA-LAST-USIZE
  imports TRUSTED-LEMMA-LAST-TO-START-KRESULT
  imports TRUSTED-LEMMA-LAST-TO-START-USIZE
  imports TRUSTED-LEMMA-POUND-LAST
  imports TRUSTED-LEMMA-POUND-LAST-EXPRESSION
  imports TRUSTED-LEMMA-POUND-LAST-USIZE
  imports TRUSTED-LEMMA-POUND-LAST-USIZE-KITEM
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-KRESULT
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-KRESULT-EXPRESSION
  imports TRUSTED-LEMMA-POUND-REMOVE-LAST-USIZE
  imports TRUSTED-LEMMA-REMOVE-LAST-KRESULT
  imports TRUSTED-LEMMA-REMOVE-LAST-USIZE

  imports LEMMAS-3
endmodule
