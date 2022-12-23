load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete",
  srcs = ["lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-commute-square-bracket",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-square-bracket-substitution",
  ],
  semantics = "//protocol-correctness/proof/lemmas/4:lemmas-4-execute",
  timeout = "moderate",
  breadth = "4",
)

ktrusted(
  name = "trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete",
  srcs = ["lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete-files",
  srcs = [":trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete"],
  deps = [
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      ":trusted-lemma-list-to-map-set-list-swap-remove-list-find-sq-b-sq-b-sq-b-delete",
  ],
  visibility = ["//visibility:public"],
)

