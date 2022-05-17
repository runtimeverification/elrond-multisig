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
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
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
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
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
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-elements-are-distinct-files",
      "//protocol-correctness/lib/functions:plistlen-functions-files",
      "//protocol-correctness/lib/functions:remove-last-files",
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
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:remove-last-files",
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
      "//protocol-correctness/lib/functions:last-functions-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-elements-are-distinct-files",
      "//protocol-correctness/lib/functions:plistlen-functions-files",
      "//protocol-correctness/lib/functions:remove-last-files",
      ":trusted-lemma-list-contains-remove-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-element-last-to-start",
  srcs = ["lemma-list-contains-unsafe-element-last-to-start.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-element-last-to-start",
  srcs = ["lemma-list-contains-unsafe-element-last-to-start.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-element-last-to-start-files",
  srcs = [":trusted-lemma-list-contains-unsafe-element-last-to-start"],
  deps = [
      "//protocol-correctness/lib/functions:last-to-start-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      ":trusted-lemma-list-contains-unsafe-element-last-to-start",
  ],
  visibility = ["//visibility:public"],
)

