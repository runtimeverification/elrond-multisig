load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "list-execute",
  srcs = ["list-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-no-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-execute-files",
  srcs = ["list-execute.k"],
  deps = [
      "//protocol-correctness/proof:main-proof-execute-no-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

