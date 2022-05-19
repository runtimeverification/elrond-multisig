load("//:proof.bzl", "kprove_test", "ktrusted")

kprove_test(
  name = "proof-count-can-sign-list-to-map-set-square-bracket-3",
  srcs = ["proof-count-can-sign-list-to-map-set-square-bracket-3.k"],
  trusted = [
      "//protocol-correctness/proof/lemmas/1/list/contains:trusted-list-contains-unsafe-change-list-3",
      "//protocol-correctness/proof/lemmas/1/list/contains:trusted-list-contains-unsafe-list-to-map-set-square-bracket-3",
  ],
  semantics = "//protocol-correctness/proof/lemmas/2:lemmas-2-execute",
  timeout = "long",
  breadth = "5",
)

ktrusted(
  name = "trusted-count-can-sign-list-to-map-set-square-bracket-3",
  srcs = ["proof-count-can-sign-list-to-map-set-square-bracket-3.k"],
  visibility = ["//visibility:public"],
)

