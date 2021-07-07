load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-execute",
  srcs = ["lemmas-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-no-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-execute-files",
  srcs = ["lemmas-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-no-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

