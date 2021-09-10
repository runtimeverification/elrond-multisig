load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-contains-last-to-start",
  srcs = ["lemma-list-contains-last-to-start.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-1:lemmas-1-execute",
  breadth = "8",
)

ktrusted(
  name = "trusted-lemma-list-contains-last-to-start",
  srcs = ["lemma-list-contains-last-to-start.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-last-to-start-files",
  srcs = [":trusted-lemma-list-contains-last-to-start"],
  deps = [
      "//protocol-correctness/lib:last-to-start-files",
      "//protocol-correctness/lib:list-contains-files",
      ":trusted-lemma-list-contains-last-to-start",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-list-find",
  srcs = ["lemma-list-contains-list-find.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-1:lemmas-1-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-list-contains-list-find",
  srcs = ["lemma-list-contains-list-find.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-list-find-files",
  srcs = [":trusted-lemma-list-contains-list-find"],
  deps = [
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:list-find-files",
      ":trusted-lemma-list-contains-list-find",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-pound-last",
  srcs = ["lemma-list-contains-pound-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-1:lemmas-1-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-list-contains-pound-last",
  srcs = ["lemma-list-contains-pound-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-pound-last-files",
  srcs = [":trusted-lemma-list-contains-pound-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      ":trusted-lemma-list-contains-pound-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-remove-last-not-pound-last",
  srcs = ["lemma-list-contains-remove-last-not-pound-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas-1:lemmas-1-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-list-contains-remove-last-not-pound-last",
  srcs = ["lemma-list-contains-remove-last-not-pound-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-remove-last-not-pound-last-files",
  srcs = [":trusted-lemma-list-contains-remove-last-not-pound-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-list-contains-remove-last-not-pound-last",
  ],
  visibility = ["//visibility:public"],
)

