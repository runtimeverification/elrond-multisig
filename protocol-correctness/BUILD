load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "pseudocode-execute",
  srcs = ["pseudocode-execute.k"],
  deps = [
      ":pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pseudocode-execute-files",
  srcs = ["pseudocode-execute.k"],
  deps = [
      ":pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "pseudocode-files",
  srcs = ["pseudocode.k"],
  deps = [
      "//protocol-correctness/lib/functions:functions-files",
      "//protocol-correctness/lib/language:language-files",
      "//protocol-correctness/lib/functions:list-contains-files",
      "//protocol-correctness/lib/functions:list-find-files",
      "//protocol-correctness/lib/functions:list-swap-remove-files",
      "//protocol-correctness/lib/functions:push-list-files",
      "//protocol-correctness/multisig/lib/language:syntax-files",
      "//protocol-correctness/multisig/lib/functions:functions-files",
      "//protocol-correctness/multisig/lib/language:language-files",
  ],
  visibility = ["//visibility:public"],
)

