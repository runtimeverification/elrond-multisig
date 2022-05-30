load("//:proof.bzl", "klibrary")

klibrary(
  name = "concretize-expression-list-files",
  srcs = ["concretize-expression-list.k"],
  deps = [
      ":concretize-value-files",
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "concretize-value-files",
  srcs = ["concretize-value.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "equality-without-substitution-files",
  srcs = ["equality-without-substitution.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "formula-expansion-files",
  srcs = ["formula-expansion.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

