load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-plistlen-remove-last",
  srcs = ["lemma-plistlen-remove-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-1:lemmas-1-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-plistlen-remove-last",
  srcs = ["lemma-plistlen-remove-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-plistlen-remove-last-files",
  srcs = [":trusted-lemma-plistlen-remove-last"],
  deps = [
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-plistlen-remove-last",
  ],
  visibility = ["//visibility:public"],
)

