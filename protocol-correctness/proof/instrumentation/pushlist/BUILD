load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

klibrary(
  name = "pushlist-instrumentation-files",
  srcs = ["pushlist-instrumentation.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-push-list-not-empty",
  srcs = ["proof-push-list-not-empty.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof:main-proof-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-push-list-not-empty",
  srcs = ["proof-push-list-not-empty.k"],
  visibility = ["//visibility:public"],
)

