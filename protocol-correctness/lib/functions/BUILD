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
  name = "add-one-if-not-negative-files",
  srcs = ["add-one-if-not-negative.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "all-keys-become-keys-files",
  srcs = ["all-keys-become-keys.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "bool-to-int-files",
  srcs = ["bool-to-int.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "forall-v-greater-or-equal-than-u-v-not-in-m-files",
  srcs = ["forall-v-greater-or-equal-than-u-v-not-in-m.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:expression-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "functions-files",
  srcs = ["functions.k"],
  deps = [
      ":add-one-if-not-negative-files",
      ":all-keys-become-keys-files",
      ":bool-to-int-files",
      ":forall-v-greater-or-equal-than-u-v-not-in-m-files",
      ":last-functions-files",
      ":last-to-start-files",
      ":list-contains-files",
      ":list-elements-are-distinct-files",
      ":list-elements-are-usize-files",
      ":list-find-files",
      ":list-first-with-default-files",
      ":list-no-common-item-files",
      ":list-swap-remove-files",
      ":list-to-map-set-files",
      ":plistlen-functions-files",
      ":prepend-files",
      ":push-list-files",
      ":remove-last-files",
      ":reverse-expression-csv-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "last-functions-files",
  srcs = ["last-functions.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
      ":plistlen-functions-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "last-to-start-files",
  srcs = ["last-to-start.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
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
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-elements-are-distinct-files",
  srcs = ["list-elements-are-distinct.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":list-contains-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-elements-are-usize-files",
  srcs = ["list-elements-are-usize.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-find-files",
  srcs = ["list-find.k"],
  deps = [
      ":add-one-if-not-negative-files",
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-first-with-default-files",
  srcs = ["list-first-with-default.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-no-common-item-files",
  srcs = ["list-no-common-item.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:expression-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-swap-remove-files",
  srcs = ["list-swap-remove.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":last-to-start-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "list-to-map-set-files",
  srcs = ["list-to-map-set.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "plistlen-functions-files",
  srcs = ["plistlen-functions.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "prepend-files",
  srcs = ["prepend.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "push-list-files",
  srcs = ["push-list.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":prepend-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "remove-last-files",
  srcs = ["remove-last.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
      ":plistlen-functions-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "reverse-expression-csv-files",
  srcs = ["reverse-expression-csv.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

