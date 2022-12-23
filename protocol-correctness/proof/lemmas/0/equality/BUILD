load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-equality-transitivity",
  srcs = ["proof-equality-transitivity.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-equality-transitivity",
  srcs = ["proof-equality-transitivity.k"],
  visibility = ["//visibility:public"],
)

