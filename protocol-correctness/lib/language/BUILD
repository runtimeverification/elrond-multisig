load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "language-execute",
  srcs = ["language-execute.k"],
  deps = [
      ":base-types-files",
      ":configuration-files",
      ":flow-files",
      ":running-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "language-execute-files",
  srcs = ["language-execute.k"],
  deps = [
      ":base-types-files",
      ":configuration-files",
      ":flow-files",
      ":running-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "base-types-files",
  srcs = ["base-types.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "caller-address-files",
  srcs = ["caller-address.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "configuration-files",
  srcs = ["configuration.k"],
  deps = [
      ":base-types-files",
      ":caller-address-files",
      ":running-syntax-files",
      ":stack-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "expression-files",
  srcs = ["expression.k"],
  deps = [
      ":base-types-files",
      ":running-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "flow-files",
  srcs = ["flow.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "for-files",
  srcs = ["for.k"],
  deps = [
      ":base-types-files",
      ":running-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "function-call-files",
  srcs = ["function-call.k"],
  deps = [
      ":base-types-files",
      ":configuration-files",
      ":flow-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "if-files",
  srcs = ["if.k"],
  deps = [
      ":base-types-files",
      ":running-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "language-list-files",
  srcs = ["language-list.k"],
  deps = [
      ":base-types-files",
      ":running-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "language-files",
  srcs = ["language.k"],
  deps = [
      ":base-types-files",
      ":expression-files",
      ":for-files",
      ":if-files",
      ":function-call-files",
      ":language-list-files",
      ":map-utils-files",
      ":mappers-files",
      ":maybe-files",
      ":memory-files",
      ":record-files",
      ":running-files",
      ":type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-utils-files",
  srcs = ["map-utils.k"],
  deps = [
      ":maybe-files",
      ":type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "mappers-files",
  srcs = ["mappers.k"],
  deps = [
      ":base-types-files",
      ":function-call-files",
      ":running-syntax-files",
      ":type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "maybe-files",
  srcs = ["maybe.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "memory-files",
  srcs = ["memory.k"],
  deps = [
      ":configuration-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "record-files",
  srcs = ["record.k"],
  deps = [
      ":base-types-files",
      ":running-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "reflection-files",
  srcs = ["reflection.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "running-syntax-files",
  srcs = ["running-syntax.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "running-files",
  srcs = ["running.k"],
  deps = [
      ":base-types-files",
      ":configuration-files",
      ":flow-files",
      ":running-syntax-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "stack-files",
  srcs = ["stack.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "type-reflection-files",
  srcs = ["type-reflection.k"],
  deps = [
      ":base-types-files",
      ":flow-files",
      ":maybe-files",
  ],
  visibility = ["//visibility:public"],
)

