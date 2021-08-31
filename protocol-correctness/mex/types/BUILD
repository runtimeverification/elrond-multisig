load("//:proof.bzl", "klibrary")

klibrary(
  name = "call-value-api-files",
  srcs = ["call-value-api.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "token-identifier-files",
  srcs = ["token-identifier.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:function-call-files",
      "//protocol-correctness/lib/language:language-files",
      "//protocol-correctness/mex:identifiers-files",
  ],
  visibility = ["//visibility:public"],
)

