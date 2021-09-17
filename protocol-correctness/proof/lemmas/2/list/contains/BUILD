load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-list-contains-pound-list-swap-remove-2",
  srcs = ["lemma-list-contains-pound-list-swap-remove-2.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "6",
)

ktrusted(
  name = "trusted-lemma-list-contains-pound-list-swap-remove-2",
  srcs = ["lemma-list-contains-pound-list-swap-remove-2.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-pound-list-swap-remove-2-files",
  srcs = [":trusted-lemma-list-contains-pound-list-swap-remove-2"],
  deps = [
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:list-swap-remove-files",
      ":trusted-lemma-list-contains-pound-list-swap-remove-2",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-pound-list-swap-remove",
  srcs = ["lemma-list-contains-pound-list-swap-remove.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "7",
)

ktrusted(
  name = "trusted-lemma-list-contains-pound-list-swap-remove",
  srcs = ["lemma-list-contains-pound-list-swap-remove.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-pound-list-swap-remove-files",
  srcs = [":trusted-lemma-list-contains-pound-list-swap-remove"],
  deps = [
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:list-swap-remove-files",
      ":trusted-lemma-list-contains-pound-list-swap-remove",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-pound-remove-last-pound-last",
  srcs = ["lemma-list-contains-pound-remove-last-pound-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-list-contains-pound-remove-last-pound-last",
  srcs = ["lemma-list-contains-pound-remove-last-pound-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-pound-remove-last-pound-last-files",
  srcs = [":trusted-lemma-list-contains-pound-remove-last-pound-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:list-elements-are-distinct-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-list-contains-pound-remove-last-pound-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-pound-remove-last",
  srcs = ["lemma-list-contains-pound-remove-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-list-contains-pound-remove-last",
  srcs = ["lemma-list-contains-pound-remove-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-pound-remove-last-files",
  srcs = [":trusted-lemma-list-contains-pound-remove-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-list-contains-pound-remove-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-remove-last",
  srcs = ["lemma-list-contains-remove-last.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-list-contains-remove-last",
  srcs = ["lemma-list-contains-remove-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-remove-last-files",
  srcs = [":trusted-lemma-list-contains-remove-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:list-elements-are-distinct-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-list-contains-remove-last",
  ],
  visibility = ["//visibility:public"],
)
