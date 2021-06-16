load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lib-execute",
  srcs = ["lib-execute.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lib-execute-files",
  srcs = ["lib-execute.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "base-types-files",
  srcs = ["base-types.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "last-functions-files",
  srcs = ["last-functions.k"],
  deps = [
      ":base-types-files",
      ":plistlen-functions-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "plistlen-functions-files",
  srcs = ["plistlen-functions.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

