load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-all-keys-become-keys-a",
  srcs = ["lemma-all-keys-become-keys-a.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas:lemmas-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-all-keys-become-keys-a",
  srcs = ["lemma-all-keys-become-keys-a.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-all-keys-become-keys-a-files",
  srcs = [":trusted-lemma-all-keys-become-keys-a"],
  deps = [
      "//protocol-correctness/lib:all-keys-become-keys-files",
      ":trusted-lemma-all-keys-become-keys-a",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-all-keys-become-keys-b",
  srcs = ["lemma-all-keys-become-keys-b.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas:lemmas-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-all-keys-become-keys-b",
  srcs = ["lemma-all-keys-become-keys-b.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-all-keys-become-keys-b-files",
  srcs = [":trusted-lemma-all-keys-become-keys-b"],
  deps = [
      "//protocol-correctness/lib:all-keys-become-keys-files",
      ":trusted-lemma-all-keys-become-keys-b",
  ],
  visibility = ["//visibility:public"],
)

