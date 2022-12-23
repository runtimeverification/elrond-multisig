load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-contains-pound-last-pound-remove-last",
  srcs = ["lemma-list-contains-pound-last-pound-remove-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/3:lemmas-3-execute",
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
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:remove-last-files",
      ":trusted-lemma-list-contains-pound-last-pound-remove-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq",
  srcs = ["lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/3:lemmas-3-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq",
  srcs = ["lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq-files",
  srcs = [":trusted-lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq"],
  deps = [
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      ":trusted-lemma-list-contains-unsafe-1-element-swap-remove-find-unsafe-neq",
  ],
  visibility = ["//visibility:public"],
)

