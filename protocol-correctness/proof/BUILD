load("//:proof.bzl", "kompile", "klibrary")

kompile(
  name = "main-proof-execute",
  srcs = ["main-proof-execute.k"],
  deps = [
      ":base-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "main-proof-execute-files",
  srcs = ["main-proof-execute.k"],
  deps = [
      ":base-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "base-files",
  srcs = ["base.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

