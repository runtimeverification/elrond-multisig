load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-count-can-sign-list-to-map-set-square-bracket-3",
  srcs = ["proof-count-can-sign-list-to-map-set-square-bracket-3.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-count-can-sign-list-to-map-set-square-bracket-3",
  srcs = ["proof-count-can-sign-list-to-map-set-square-bracket-3.k"],
  visibility = ["//visibility:public"],
)

