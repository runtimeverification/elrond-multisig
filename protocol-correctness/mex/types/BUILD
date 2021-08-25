load("//:proof.bzl", "klibrary")

klibrary(
  name = "token-identifier-files",
  srcs = ["token-identifier.k"],
  deps = [
      "//protocol-correctness/lib/language:function-call-files",
      "//protocol-correctness/lib/language:language-files",
      "//protocol-correctness/mex:identifiers-files",
  ],
  visibility = ["//visibility:public"],
)

