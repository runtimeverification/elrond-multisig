load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "main-proof-execute",
  srcs = ["main-proof-execute.k"],
  deps = [
      "//protocol-correctness/mex:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "main-proof-execute-files",
  srcs = ["main-proof-execute.k"],
  deps = [
      "//protocol-correctness/mex:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

