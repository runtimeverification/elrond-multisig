load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-list-contains-unsafe-list-to-map-set-square-bracket-3",
  srcs = ["proof-list-contains-unsafe-list-to-map-set-square-bracket-3.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-list-contains-unsafe-list-to-map-set-square-bracket-3",
  srcs = ["proof-list-contains-unsafe-list-to-map-set-square-bracket-3.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-second-element",
  srcs = ["lemma-list-contains-unsafe-second-element.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-second-element",
  srcs = ["lemma-list-contains-unsafe-second-element.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-second-element-files",
  srcs = [":trusted-lemma-list-contains-unsafe-second-element"],
  deps = [
      "//protocol-correctness/lib/functions:list-contains-files",
      ":trusted-lemma-list-contains-unsafe-second-element",
  ],
  visibility = ["//visibility:public"],
)

