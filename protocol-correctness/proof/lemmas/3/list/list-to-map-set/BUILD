load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-to-map-set-list-swap-remove-list-find-delete",
  srcs = ["lemma-list-to-map-set-list-swap-remove-list-find-delete.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-commute-square-bracket",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-square-bracket-substitution",
  ],
  semantics = "//protocol-correctness/proof/lemmas/3:lemmas-3-execute",
  timeout = "moderate",
  breadth = "5",
)

ktrusted(
  name = "trusted-lemma-list-to-map-set-list-swap-remove-list-find-delete",
  srcs = ["lemma-list-to-map-set-list-swap-remove-list-find-delete.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-to-map-set-list-swap-remove-list-find-delete-files",
  srcs = [":trusted-lemma-list-to-map-set-list-swap-remove-list-find-delete"],
  deps = [
      "//protocol-correctness/lib:list-find-files",
      "//protocol-correctness/lib:list-swap-remove-files",
      "//protocol-correctness/lib:list-to-map-set-files",
      ":trusted-lemma-list-to-map-set-list-swap-remove-list-find-delete",
  ],
  visibility = ["//visibility:public"],
)

