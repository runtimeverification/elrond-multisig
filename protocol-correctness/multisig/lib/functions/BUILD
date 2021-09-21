load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "functions-execute",
  srcs = ["functions-execute.k"],
  deps = [
      ":functions-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "functions-execute-files",
  srcs = ["functions-execute.k"],
  deps = [
      ":functions-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "at-most-this-signer-list-files",
  srcs = ["at-most-this-signer-list.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":can-sign-function-files",
      "//protocol-correctness/multisig/lib/language:cast-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "can-sign-function-files",
  srcs = ["can-sign-function.k"],
  deps = [
      "//protocol-correctness/multisig/lib/language:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "code-metadata-function-files",
  srcs = ["code-metadata-function.k"],
  deps = [
      ":metadata-to-int-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "concretize-value-files",
  srcs = ["concretize-value.k"],
  deps = [
      "//protocol-correctness/lib/functions:concretize-value-files",
      "//protocol-correctness/multisig/lib/language:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "count-can-sign-function-files",
  srcs = ["count-can-sign-function.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":can-sign-function-files",
      "//protocol-correctness/multisig/lib/language:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "functions-files",
  srcs = ["functions.k"],
  deps = [
      ":can-sign-function-files",
      ":code-metadata-function-files",
      ":concretize-value-files",
      ":count-can-sign-function-files",
      ":metadata-to-int-files",
      ":only-this-signer-diffs-files",
      ":pound-at-most-this-signer-list-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "metadata-to-int-files",
  srcs = ["metadata-to-int.k"],
  deps = [
      "//protocol-correctness/multisig/lib/language:syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "only-this-signer-diffs-files",
  srcs = ["only-this-signer-diffs.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      ":pound-at-most-this-signer-list-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pound-at-most-this-signer-list-files",
  srcs = ["pound-at-most-this-signer-list.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":can-sign-function-files",
      "//protocol-correctness/multisig/lib/language:cast-files",
  ],
  visibility = ["//visibility:public"],
)

