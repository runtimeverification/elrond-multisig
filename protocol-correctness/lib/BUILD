load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lib-execute",
  srcs = ["lib-execute.k"],
  deps = [
      ":lib-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lib-execute-files",
  srcs = ["lib-execute.k"],
  deps = [
      ":lib-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lib-files",
  srcs = ["lib.k"],
  deps = [
      "//protocol-correctness/lib/functions:functions-files",
  ],
  visibility = ["//visibility:public"],
)

