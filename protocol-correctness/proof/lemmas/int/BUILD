load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-add-one-if-not-negative",
  srcs = ["lemma-add-one-if-not-negative.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas:lemmas-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-add-one-if-not-negative",
  srcs = ["lemma-add-one-if-not-negative.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-add-one-if-not-negative-files",
  srcs = [":trusted-lemma-add-one-if-not-negative"],
  deps = [
      "//protocol-correctness/lib:add-one-if-not-negative-files",
      ":trusted-lemma-add-one-if-not-negative",
  ],
  visibility = ["//visibility:public"],
)

