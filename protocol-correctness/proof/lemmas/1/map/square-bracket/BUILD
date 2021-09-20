load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-square-bracket-sq-b-sq-b-undef",
  srcs = ["lemma-square-bracket-sq-b-sq-b-undef.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/0/map/square-bracket:trusted-commute-square-bracket",
  ],
  semantics = "//protocol-correctness/proof/lemmas/1:lemmas-1-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-square-bracket-sq-b-sq-b-undef",
  srcs = ["lemma-square-bracket-sq-b-sq-b-undef.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-square-bracket-sq-b-sq-b-undef-files",
  srcs = [":trusted-lemma-square-bracket-sq-b-sq-b-undef"],
  deps = [
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      ":trusted-lemma-square-bracket-sq-b-sq-b-undef",
  ],
  visibility = ["//visibility:public"],
)

