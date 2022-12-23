load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-init",
  srcs = ["proof-init.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/mex/proof:main-proof-execute",
  timeout = "long",
  breadth = "8",
)

ktrusted(
  name = "trusted-init",
  srcs = ["proof-init.k"],
  visibility = ["//visibility:public"],
)

