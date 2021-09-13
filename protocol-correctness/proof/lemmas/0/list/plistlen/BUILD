load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-plistlen",
  srcs = ["lemma-plistlen.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-plistlen",
  srcs = ["lemma-plistlen.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-plistlen-files",
  srcs = [":trusted-lemma-plistlen"],
  deps = [
      "//protocol-correctness/lib:plistlen-functions-files",
      ":trusted-lemma-plistlen",
  ],
  visibility = ["//visibility:public"],
)

