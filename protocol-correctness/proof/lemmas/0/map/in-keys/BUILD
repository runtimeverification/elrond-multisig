load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-in-keys-substitution",
  srcs = ["proof-in-keys-substitution.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-in-keys-substitution",
  srcs = ["proof-in-keys-substitution.k"],
  visibility = ["//visibility:public"],
)

