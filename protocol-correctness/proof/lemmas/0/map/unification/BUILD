load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-two-element-vs-one-element",
  srcs = ["proof-two-element-vs-one-element.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-two-element-vs-one-element",
  srcs = ["proof-two-element-vs-one-element.k"],
  visibility = ["//visibility:public"],
)

