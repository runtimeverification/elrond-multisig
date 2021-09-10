load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lemmas-final-execute",
  srcs = ["lemmas-final-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-5:lemmas-5-execute-files",
      ":lemmas-final-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-final-execute-files",
  srcs = ["lemmas-final-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-5:lemmas-5-execute-files",
      ":lemmas-final-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-final-files",
  srcs = ["lemmas-final.k"],
  deps = [
      "//protocol-correctness/proof/lemmas-5:lemmas-4-files",
  ],
  visibility = ["//visibility:public"],
)

