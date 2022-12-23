load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-plistlen-last-to-start",
  srcs = ["lemma-plistlen-last-to-start.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-plistlen-last-to-start",
  srcs = ["lemma-plistlen-last-to-start.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-plistlen-last-to-start-files",
  srcs = [":trusted-lemma-plistlen-last-to-start"],
  deps = [
      "//protocol-correctness/lib/functions:plistlen-functions-files",
      "//protocol-correctness/lib/functions:last-to-start-files",
      ":trusted-lemma-plistlen-last-to-start",
  ],
  visibility = ["//visibility:public"],
)

