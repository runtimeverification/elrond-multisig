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
  name = "identifiers-files",
  srcs = ["identifiers.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pair-files",
  srcs = ["pair.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:running-syntax-files",
      "//protocol-correctness/mex/types:token-identifier-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pseudocode-files",
  srcs = ["pseudocode.k"],
  deps = [
      "//protocol-correctness/lib/language:language-files",
  ],
  visibility = ["//visibility:public"],
)

