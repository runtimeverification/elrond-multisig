load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-to-map-set-square-bracket-list-contains-unsafe",
  srcs = ["lemma-list-to-map-set-square-bracket-list-contains-unsafe.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/0/list/contains:trusted-list-contains-unsafe-to-in-keys",
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-list-to-map-set-square-bracket-list-contains-unsafe",
  srcs = ["lemma-list-to-map-set-square-bracket-list-contains-unsafe.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-to-map-set-square-bracket-list-contains-unsafe-files",
  srcs = [":trusted-lemma-list-to-map-set-square-bracket-list-contains-unsafe"],
  deps = [
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      ":trusted-lemma-list-to-map-set-square-bracket-list-contains-unsafe",
  ],
  visibility = ["//visibility:public"],
)

