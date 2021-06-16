load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "last-execute",
  srcs = ["last-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/list:list-execute-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "last-execute-files",
  srcs = ["last-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/list:list-execute-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-last",
  srcs = ["lemma-last.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-last",
  srcs = ["lemma-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-last-files",
  srcs = [":trusted-lemma-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      ":trusted-lemma-last",
  ],
  visibility = ["//visibility:public"],
)

