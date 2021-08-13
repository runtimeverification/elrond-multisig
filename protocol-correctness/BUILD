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
      "//protocol-correctness/lib/language:language-files",
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:last-to-start-files",
      "//protocol-correctness/lib:list-contains-files",
      "//protocol-correctness/lib:list-find-files",
      "//protocol-correctness/lib:list-swap-remove-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:prepend-files",
      "//protocol-correctness/lib:push-list-files",
      "//protocol-correctness/lib:remove-last-files",
  ],
  visibility = ["//visibility:public"],
)

