load("//:proof.bzl", "kompile", "klibrary")

kompile(
  name = "main-proof-execute",
  srcs = ["main-proof-execute.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
      ":base-files",
      ":invariant-files",
      ":execution-proof-helpers-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "main-proof-execute-files",
  srcs = ["main-proof-execute.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
      ":base-files",
      ":invariant-files",
      ":execution-proof-helpers-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "base-files",
  srcs = ["base.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "execution-proof-helpers-files",
  srcs = ["execution-proof-helpers.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
      "//protocol-correctness/proof/map:map-execute-files",
      ":base-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "invariant-files",
  srcs = ["invariant.k"],
  deps = [
      ":execution-proof-helpers-files",
  ],
  visibility = ["//visibility:public"],
)

