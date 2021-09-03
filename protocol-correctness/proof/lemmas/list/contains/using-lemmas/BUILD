load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "using-lemmas-execute",
  srcs = ["using-lemmas-execute.k"],
  deps = [
      "//protocol-correctness/lib/proof/induction:syntax-files",
      "//protocol-correctness/proof/lemmas/list/contains:contains-execute-files",
      "//protocol-correctness/proof/lemmas/list/contains:trusted-lemma-list-contains-pound-last-files",
      "//protocol-correctness/proof/lemmas/list/contains:trusted-lemma-list-contains-remove-last-not-pound-last-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "using-lemmas-execute-files",
  srcs = ["using-lemmas-execute.k"],
  deps = [
      "//protocol-correctness/lib/proof/induction:syntax-files",
      "//protocol-correctness/proof/lemmas/list/contains:contains-execute-files",
      "//protocol-correctness/proof/lemmas/list/contains:trusted-lemma-list-contains-pound-last-files",
      "//protocol-correctness/proof/lemmas/list/contains:trusted-lemma-list-contains-remove-last-not-pound-last-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-pound-last-pound-remove-last",
  srcs = ["lemma-list-contains-pound-last-pound-remove-last.k"],
  trusted = [
  ],
  semantics = "using-lemmas-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-list-contains-pound-last-pound-remove-last",
  srcs = ["lemma-list-contains-pound-last-pound-remove-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-pound-last-pound-remove-last-files",
  srcs = [":trusted-lemma-list-contains-pound-last-pound-remove-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-list-contains-pound-last-pound-remove-last",
  ],
  visibility = ["//visibility:public"],
)

