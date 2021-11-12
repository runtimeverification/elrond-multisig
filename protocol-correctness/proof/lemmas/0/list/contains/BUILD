load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-list-contains-unsafe-list-to-map-set-square-bracket-3",
  srcs = ["proof-list-contains-unsafe-list-to-map-set-square-bracket-3.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-list-contains-unsafe-list-to-map-set-square-bracket-3",
  srcs = ["proof-list-contains-unsafe-list-to-map-set-square-bracket-3.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq",
  srcs = ["lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq",
  srcs = ["lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq-files",
  srcs = [":trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq"],
  deps = [
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      ":trusted-lemma-list-contains-unsafe-2-element-swap-remove-find-unsafe-neq",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-element-last-to-start",
  srcs = ["lemma-list-contains-unsafe-element-last-to-start.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
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

kprove_test(
  name = "lemma-list-contains-unsafe-second-element",
  srcs = ["lemma-list-contains-unsafe-second-element.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-second-element",
  srcs = ["lemma-list-contains-unsafe-second-element.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-second-element-files",
  srcs = [":trusted-lemma-list-contains-unsafe-second-element"],
  deps = [
      "//protocol-correctness/lib/functions:list-contains-files",
      ":trusted-lemma-list-contains-unsafe-second-element",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-swap-remove-find-unsafe-eq",
  srcs = ["lemma-list-contains-unsafe-swap-remove-find-unsafe-eq.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-eq",
  srcs = ["lemma-list-contains-unsafe-swap-remove-find-unsafe-eq.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-eq-files",
  srcs = [":trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-eq"],
  deps = [
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-elements-are-distinct-files",
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      ":trusted-lemma-list-contains-unsafe-swap-remove-find-unsafe-eq",
  ],
  visibility = ["//visibility:public"],
)

