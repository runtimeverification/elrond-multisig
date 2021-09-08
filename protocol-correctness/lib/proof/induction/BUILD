load("//:proof.bzl", "klibrary")

klibrary(
  name = "call-files",
  srcs = ["call.k"],
  deps = [
      ":syntax-files",
      ":internal-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "case-files",
  srcs = ["case.k"],
  deps = [
      ":syntax-files",
      ":internal-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "data-item-files",
  srcs = ["data-item.k"],
  deps = [
      ":syntax-files",
      ":internal-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "expression-list-files",
  srcs = ["expression-list.k"],
  deps = [
      ":expression-files",
      ":internal-syntax-files",
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "expression-files",
  srcs = ["expression.k"],
  deps = [
      "//protocol-correctness/lib/language:reflection-files",
      ":internal-syntax-files",
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "induction-files",
  srcs = ["induction.k"],
  deps = [
      ":call-files",
      ":case-files",
      ":data-item-files",
      ":expression-files",
      ":expression-list-files",
      ":reinduction-files",
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "internal-syntax-files",
  srcs = ["internal-syntax.k"],
  deps = [
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "reinduction-files",
  srcs = ["reinduction.k"],
  deps = [
      ":data-item-files",
      ":internal-syntax-files",
      ":syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "syntax-files",
  srcs = ["syntax.k"],
  deps = [
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

