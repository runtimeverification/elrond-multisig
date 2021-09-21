load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "language-execute",
  srcs = ["language-execute.k"],
  deps = [
      ":language-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "language-execute-files",
  srcs = ["language-execute.k"],
  deps = [
      ":language-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "cast-files",
  srcs = ["cast.k"],
  deps = [
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "kresult-files",
  srcs = ["kresult.k"],
  deps = [
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "language-files",
  srcs = ["language.k"],
  deps = [
      ":cast-files",
      ":kresult-files",
      ":syntax-files",
      ":type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "syntax-files",
  srcs = ["syntax.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:running-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "type-reflection-files",
  srcs = ["type-reflection.k"],
  deps = [
      "//protocol-correctness/lib/language:flow-files",
      "//protocol-correctness/lib/language:reflection-files",
      "//protocol-correctness/lib/language:type-reflection-files",
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

