load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-bool-to-int-sum-and-not",
  srcs = ["proof-bool-to-int-sum-and-not.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-bool-to-int-sum-and-not",
  srcs = ["proof-bool-to-int-sum-and-not.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-implies",
  srcs = ["proof-implies.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-implies",
  srcs = ["proof-implies.k"],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-bool-to-int-andbool-le-bool-to-int",
  srcs = ["lemma-bool-to-int-andbool-le-bool-to-int.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-bool-to-int-andbool-le-bool-to-int",
  srcs = ["lemma-bool-to-int-andbool-le-bool-to-int.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-bool-to-int-andbool-le-bool-to-int-files",
  srcs = [":trusted-lemma-bool-to-int-andbool-le-bool-to-int"],
  deps = [
      "//protocol-correctness/lib/functions:bool-to-int-files",
      ":trusted-lemma-bool-to-int-andbool-le-bool-to-int",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-bool-to-int-ge-0",
  srcs = ["lemma-bool-to-int-ge-0.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-bool-to-int-ge-0",
  srcs = ["lemma-bool-to-int-ge-0.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-bool-to-int-ge-0-files",
  srcs = [":trusted-lemma-bool-to-int-ge-0"],
  deps = [
      "//protocol-correctness/lib/functions:bool-to-int-files",
      ":trusted-lemma-bool-to-int-ge-0",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-bool-to-int-le-1",
  srcs = ["lemma-bool-to-int-le-1.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-bool-to-int-le-1",
  srcs = ["lemma-bool-to-int-le-1.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-bool-to-int-le-1-files",
  srcs = [":trusted-lemma-bool-to-int-le-1"],
  deps = [
      "//protocol-correctness/lib/functions:bool-to-int-files",
      ":trusted-lemma-bool-to-int-le-1",
  ],
  visibility = ["//visibility:public"],
)

