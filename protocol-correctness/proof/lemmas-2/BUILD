load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-2-execute",
  srcs = ["lemmas-2-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-1:lemmas-1-execute-files",
      ":lemmas-1-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-2-execute-files",
  srcs = ["lemmas-2-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-1:lemmas-1-execute-files",
      ":lemmas-1-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-1-files",
  srcs = ["lemmas-1.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-1/list/plistlen:trusted-lemma-plistlen-remove-last-files",
      "//protocol-correctness/proof/lemmas-1:lemmas-0-files",
  ],
  visibility = ["//visibility:public"],
)

