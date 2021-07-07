load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "lib-execute",
  srcs = ["lib-execute.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lib-execute-files",
  srcs = ["lib-execute.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "add-one-if-not-negative-files",
  srcs = ["add-one-if-not-negative.k"],
  deps = [
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
  name = "last-functions-files",
  srcs = ["last-functions.k"],
  deps = [
      ":base-types-files",
      ":plistlen-functions-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "last-to-start-files",
  srcs = ["last-to-start.k"],
  deps = [
      ":base-types-files",
      ":last-functions-files",
      ":plistlen-functions-files",
      ":remove-last-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-contains-files",
  srcs = ["list-contains.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-elements-are-distinct-files",
  srcs = ["list-elements-are-distinct.k"],
  deps = [
      ":base-types-files",
      ":list-contains-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-elements-are-usize-files",
  srcs = ["list-elements-are-usize.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-find-files",
  srcs = ["list-find.k"],
  deps = [
      ":base-types-files",
      ":add-one-if-not-negative-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-swap-remove-files",
  srcs = ["list-swap-remove.k"],
  deps = [
      ":base-types-files",
      ":last-to-start-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "plistlen-functions-files",
  srcs = ["plistlen-functions.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "prepend-files",
  srcs = ["prepend.k"],
  deps = [
      ":base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "push-list-files",
  srcs = ["push-list.k"],
  deps = [
      ":base-types-files",
      ":prepend-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "remove-last-files",
  srcs = ["remove-last.k"],
  deps = [
      ":base-types-files",
      ":plistlen-functions-files",
  ],
  visibility = ["//visibility:public"],
)

