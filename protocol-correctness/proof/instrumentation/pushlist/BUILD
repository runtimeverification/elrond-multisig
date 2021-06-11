load("//:proof.bzl", "kompile", "klibrary", "kprove_test", "ktrusted")

kompile(
  name = "pushlist-execute",
  srcs = ["pushlist-execute.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pushlist-execute-files",
  srcs = ["pushlist-execute.k"],
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
  semantics = "pushlist-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-push-list-not-empty",
  srcs = ["proof-push-list-not-empty.k"],
  visibility = ["//visibility:public"],
)

