load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-list-to-map-set-concretize",
  srcs = ["proof-list-to-map-set-concretize.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "1",
)

ktrusted(
  name = "trusted-list-to-map-set-concretize",
  srcs = ["proof-list-to-map-set-concretize.k"],
  visibility = ["//visibility:public"],
)

