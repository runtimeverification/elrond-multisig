load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "mex-execute",
  srcs = ["mex-execute.k"],
  deps = [
      ":pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "mex-execute-files",
  srcs = ["mex-execute.k"],
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
      ":identifiers-files",
      "//protocol-correctness/mex/types:token-identifier-files",
      "//protocol-correctness/mex/types:call-value-api-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pseudocode-files",
  srcs = ["pseudocode.k"],
  deps = [
      "//protocol-correctness/lib/language:language-files",
      ":pair-files",
  ],
  visibility = ["//visibility:public"],
)

