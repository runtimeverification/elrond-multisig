load("//:proof.bzl", "klibrary", "kompile")

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
      "//protocol-correctness/lib:base-types-files",
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
  ],
  visibility = ["//visibility:public"],
)

