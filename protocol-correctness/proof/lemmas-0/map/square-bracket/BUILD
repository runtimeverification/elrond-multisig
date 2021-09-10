load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-commute-square-bracket",
  srcs = ["proof-commute-square-bracket.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-0:lemmas-0-execute",
  breadth = "5",
)

ktrusted(
  name = "trusted-commute-square-bracket",
  srcs = ["proof-commute-square-bracket.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-square-bracket-substitution",
  srcs = ["proof-square-bracket-substitution.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-square-bracket-substitution",
  srcs = ["proof-square-bracket-substitution.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-square-bracket-square-bracket-undef",
  srcs = ["lemma-square-bracket-square-bracket-undef.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-square-bracket-square-bracket-undef",
  srcs = ["lemma-square-bracket-square-bracket-undef.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-square-bracket-square-bracket-undef-files",
  srcs = [":trusted-lemma-square-bracket-square-bracket-undef"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      ":trusted-lemma-square-bracket-square-bracket-undef",
  ],
  visibility = ["//visibility:public"],
)

