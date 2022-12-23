load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-map-keys-are-below-limit-ignore-property-handling",
  srcs = ["proof-map-keys-are-below-limit-ignore-property-handling.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-map-keys-are-below-limit-ignore-property-handling",
  srcs = ["proof-map-keys-are-below-limit-ignore-property-handling.k"],
  visibility = ["//visibility:public"],
)

