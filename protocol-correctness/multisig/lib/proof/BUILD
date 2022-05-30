load("//:proof.bzl", "klibrary")

klibrary(
  name = "multisig-proof-files",
  srcs = ["multisig-proof.k"],
  deps = [
      "//protocol-correctness/multisig/lib/proof/unsorted:concretize-value-files",
  ],
  visibility = ["//visibility:public"],
)

