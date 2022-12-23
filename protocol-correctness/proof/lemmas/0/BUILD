load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-0-execute",
  srcs = ["lemmas-0-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-0-execute-files",
  srcs = ["lemmas-0-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-files",
  ],
  visibility = ["//visibility:public"],
)

