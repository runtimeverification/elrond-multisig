load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-plistlen-list-swap-remove-list-find",
  srcs = ["lemma-plistlen-list-swap-remove-list-find.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/3:lemmas-3-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-plistlen-list-swap-remove-list-find",
  srcs = ["lemma-plistlen-list-swap-remove-list-find.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-plistlen-list-swap-remove-list-find-files",
  srcs = [":trusted-lemma-plistlen-list-swap-remove-list-find"],
  deps = [
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      "//protocol-correctness/lib/functions:plistlen-functions-files",
      ":trusted-lemma-plistlen-list-swap-remove-list-find",
  ],
  visibility = ["//visibility:public"],
)

