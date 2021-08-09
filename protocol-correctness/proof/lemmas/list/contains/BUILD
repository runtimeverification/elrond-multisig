load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "contains-execute",
  srcs = ["contains-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas:lemmas-execute-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "contains-execute-files",
  srcs = ["contains-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas:lemmas-execute-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-last-distinct",
  srcs = ["proof-last-distinct.k"],
  trusted = [
  ],
  semantics = "contains-execute",
  breadth = "10",
)

ktrusted(
  name = "trusted-last-distinct",
  srcs = ["proof-last-distinct.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-last-to-start",
  srcs = ["lemma-list-contains-last-to-start.k"],
  trusted = [
  ],
  semantics = "contains-execute",
  breadth = "6",
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
  name = "lemma-list-contains-pound-list-swap-remove-2",
  srcs = ["lemma-list-contains-pound-list-swap-remove-2.k"],
  trusted = [
  ],
  semantics = "contains-execute",
  breadth = "1",
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
  semantics = "contains-execute",
  breadth = "1",
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
  name = "lemma-list-contains-pound-remove-last",
  srcs = ["lemma-list-contains-pound-remove-last.k"],
  trusted = [
  ],
  semantics = "contains-execute",
  breadth = "1",
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
      "//protocol-correctness/lib:list-elements-are-distinct-files",
      "//protocol-correctness/lib:plistlen-functions-files",
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
  semantics = "contains-execute",
  breadth = "1",
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

