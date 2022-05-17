load("//:proof.bzl", "klibrary")

klibrary(
  name = "concretize-value-files",
  srcs = ["concretize-value.k"],
  deps = [
      "//protocol-correctness/lib/proof/unsorted:concretize-value-files",
      "//protocol-correctness/multisig/lib/language:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

