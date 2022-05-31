load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-1-execute",
  srcs = ["lemmas-1-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/0:lemmas-0-execute-files",
      ":lemmas-0-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-1-execute-files",
  srcs = ["lemmas-1-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/0:lemmas-0-execute-files",
      ":lemmas-0-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-0-files",
  srcs = ["lemmas-0.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/0/bool:trusted-lemma-bool-to-int-andbool-le-bool-to-int-files",
      "//protocol-correctness/proof/lemmas/0/bool:trusted-lemma-bool-to-int-ge-0-files",
      "//protocol-correctness/proof/lemmas/0/bool:trusted-lemma-bool-to-int-le-1-files",
      "//protocol-correctness/proof/lemmas/0/int:trusted-lemma-add-one-if-not-negative-files",
      "//protocol-correctness/proof/lemmas/0/int:trusted-lemma-add-one-if-not-negative-not-zero-files",
      "//protocol-correctness/proof/lemmas/0/invariant:trusted-lemma-map-keys-are-kresult-user-id-to-role-files",
      "//protocol-correctness/proof/lemmas/0/list/contains:trusted-lemma-list-contains-unsafe-list-to-map-set-files",
      "//protocol-correctness/proof/lemmas/0/list/contains:trusted-lemma-list-contains-unsafe-second-element-files",
      "//protocol-correctness/proof/lemmas/0/list/list-to-map-set:trusted-lemma-list-to-map-set-square-bracket-list-contains-unsafe-files",
      "//protocol-correctness/proof/lemmas/0/list/no-map-key-in-list:trusted-lemma-no-map-key-in-list-push-list-not-in-map-files",
      "//protocol-correctness/proof/lemmas/0/list/plistlen:trusted-lemma-plistlen-files",
      "//protocol-correctness/proof/lemmas/0/map/all-keys-become-keys:trusted-lemma-all-keys-become-keys-a-files",
      "//protocol-correctness/proof/lemmas/0/map/all-keys-become-keys:trusted-lemma-all-keys-become-keys-b-files",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-lemma-in-keys-square-bracket-undef-files",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-lemma-square-bracket-ordefault-not-in-keys-files",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-lemma-square-bracket-square-bracket-undef-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-2-elements-swap-remove-find-unsafe-not-in-keys-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-function-element-last-to-start-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-function-last-remove-last-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-function-second-element-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-map-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-map-empty-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-push-list-files",
      "//protocol-correctness/proof/lemmas/0/signers:trusted-lemma-count-can-sign-push-list-2-files",
  ],
  visibility = ["//visibility:public"],
)

