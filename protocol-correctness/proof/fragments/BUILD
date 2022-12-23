load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-make-concrete-value-fragment",
  srcs = ["proof-make-concrete-value-fragment.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "4",
)

ktrusted(
  name = "trusted-make-concrete-value-fragment",
  srcs = ["proof-make-concrete-value-fragment.k"],
  visibility = ["//visibility:public"],
)

