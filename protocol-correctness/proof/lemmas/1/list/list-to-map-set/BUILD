load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-to-map-set-pound-remove-last-pound-last",
  srcs = ["lemma-list-to-map-set-pound-remove-last-pound-last.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-commute-square-bracket",
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-square-bracket-substitution",
      "//protocol-correctness/proof/lemmas/0/equality:trusted-equality-transitivity",
  ],
  semantics = "//protocol-correctness/proof/lemmas/1:lemmas-1-execute",
  timeout = "moderate",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-list-to-map-set-pound-remove-last-pound-last",
  srcs = ["lemma-list-to-map-set-pound-remove-last-pound-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-to-map-set-pound-remove-last-pound-last-files",
  srcs = [":trusted-lemma-list-to-map-set-pound-remove-last-pound-last"],
  deps = [
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      "//protocol-correctness/lib/functions:remove-last-files",
      ":trusted-lemma-list-to-map-set-pound-remove-last-pound-last",
  ],
  visibility = ["//visibility:public"],
)

