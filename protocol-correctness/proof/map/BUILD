load("//:proof.bzl", "kompile", "klibrary", "kprove_test", "ktrusted")

kompile(
  name = "map-execute",
  srcs = ["map-execute.k"],
  deps = [
      "//protocol-correctness/proof:base-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-execute-files",
  srcs = ["map-execute.k"],
  deps = [
      "//protocol-correctness/proof:base-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-map-semantics",
  srcs = ["proof-map-semantics.k"],
  trusted = [
  ],
  semantics = "map-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-map-semantics",
  srcs = ["proof-map-semantics.k"],
  visibility = ["//visibility:public"],
)

