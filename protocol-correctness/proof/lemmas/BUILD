load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-execute",
  srcs = ["lemmas-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/5:lemmas-5-execute-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-execute-files",
  srcs = ["lemmas-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/5:lemmas-5-execute-files",
  ],
  visibility = ["//visibility:public"],
)

