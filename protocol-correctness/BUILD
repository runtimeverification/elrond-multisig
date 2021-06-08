load("//:proof.bzl", "kompile", "klibrary")

kompile(
  name = "pseudocode-execute",
  srcs = ["pseudocode-execute.k"],
  deps = [
      ":pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pseudocode-execute-files",
  srcs = ["pseudocode-execute.k"],
  deps = [
      ":pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pseudocode-files",
  srcs = ["pseudocode.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

