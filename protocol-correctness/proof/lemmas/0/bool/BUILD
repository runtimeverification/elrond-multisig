load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-implies",
  srcs = ["proof-implies.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-implies",
  srcs = ["proof-implies.k"],
  visibility = ["//visibility:public"],
)

