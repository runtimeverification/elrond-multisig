load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-1-execute",
  srcs = ["lemmas-1-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-0:lemmas-0-execute-files",
      ":lemmas-0-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-1-execute-files",
  srcs = ["lemmas-1-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-0:lemmas-0-execute-files",
      ":lemmas-0-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-0-files",
  srcs = ["lemmas-0.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-0/int:trusted-lemma-add-one-if-not-negative-files",
      "//protocol-correctness/proof/lemmas-0/list/plistlen:trusted-lemma-plistlen-files",
      "//protocol-correctness/proof/lemmas-0/map/all-keys-become-keys:trusted-lemma-all-keys-become-keys-a-files",
      "//protocol-correctness/proof/lemmas-0/map/all-keys-become-keys:trusted-lemma-all-keys-become-keys-b-files",
      "//protocol-correctness/proof/lemmas-0/map/square-bracket:trusted-lemma-square-bracket-square-bracket-undef-files",
  ],
  visibility = ["//visibility:public"],
)

