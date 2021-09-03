load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-4-execute",
  srcs = ["lemmas-4-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-3:lemmas-3-execute-files",
      ":lemmas-3-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-4-execute-files",
  srcs = ["lemmas-4-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-3:lemmas-3-execute-files",
      ":lemmas-3-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-3-files",
  srcs = ["lemmas-3.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-3/list/plistlen:trusted-lemma-plistlen-list-swap-remove-list-find-files",
      "//protocol-correctness/proof/lemmas-3:lemmas-2-files",
  ],
  visibility = ["//visibility:public"],
)

