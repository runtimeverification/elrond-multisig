load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-to-map-set-last-to-start",
  srcs = ["lemma-list-to-map-set-last-to-start.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-commute-square-bracket",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-square-bracket-substitution",
      "//protocol-correctness/proof/lemmas/0/equality:trusted-equality-transitivity",
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-list-to-map-set-last-to-start",
  srcs = ["lemma-list-to-map-set-last-to-start.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-to-map-set-last-to-start-files",
  srcs = [":trusted-lemma-list-to-map-set-last-to-start"],
  deps = [
      "//protocol-correctness/lib/functions:last-to-start-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      ":trusted-lemma-list-to-map-set-last-to-start",
  ],
  visibility = ["//visibility:public"],
)

