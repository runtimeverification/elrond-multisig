load("//:proof.bzl", "klibrary")

klibrary(
  name = "language-proof-files",
  srcs = ["language-proof.k"],
  deps = [
      "//protocol-correctness/lib/proof/unsorted:concretize-expression-list-files",
      "//protocol-correctness/lib/proof/unsorted:concretize-value-files",
      "//protocol-correctness/lib/proof/unsorted:equality-without-substitution-files",
  ],
  visibility = ["//visibility:public"],
)

