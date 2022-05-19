load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-list-contains-unsafe-to-in-keys",
  srcs = ["proof-list-contains-unsafe-to-in-keys.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-list-contains-unsafe-to-in-keys",
  srcs = ["proof-list-contains-unsafe-to-in-keys.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-list-contains-unsafe-list-to-map-set",
  srcs = ["lemma-list-contains-unsafe-list-to-map-set.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-list-contains-unsafe-list-to-map-set",
  srcs = ["lemma-list-contains-unsafe-list-to-map-set.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-list-contains-unsafe-list-to-map-set-files",
  srcs = [":trusted-lemma-list-contains-unsafe-list-to-map-set"],
  deps = [
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      ":trusted-lemma-list-contains-unsafe-list-to-map-set",
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

