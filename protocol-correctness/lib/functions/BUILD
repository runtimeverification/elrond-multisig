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
  name = "can-add-list-elements-at-index-files",
  srcs = ["can-add-list-elements-at-index.k"],
  deps = [
      ":forall-v-greater-or-equal-than-u-v-not-in-m-files",
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:expression-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "can-add-value-for-list-elements-at-index-files",
  srcs = ["can-add-value-for-list-elements-at-index.k"],
  deps = [
      ":forall-v-greater-or-equal-than-u-v-not-in-m-files",
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:expression-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "concretize-expression-list-files",
  srcs = ["concretize-expression-list.k"],
  deps = [
      ":concretize-value-files",
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "concretize-value-files",
  srcs = ["concretize-value.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "first-or-default-files",
  srcs = ["first-or-default.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
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
      ":can-add-list-elements-at-index-files",
      ":can-add-value-for-list-elements-at-index-files",
      ":concretize-value-files",
      ":concretize-expression-list-files",
      ":first-or-default-files",
      ":forall-v-greater-or-equal-than-u-v-not-in-m-files",
      ":keys-map-files",
      ":last-functions-files",
      ":last-to-start-files",
      ":list-contains-files",
      ":list-elements-are-distinct-files",
      ":list-elements-are-of-type-files",
      ":list-elements-are-usize-files",
      ":list-find-files",
      ":list-first-with-default-files",
      ":list-no-common-item-files",
      ":list-swap-remove-files",
      ":list-to-map-set-files",
      ":map-included-files",
      ":map-keys-are-below-limit-files",
      ":map-keys-are-kresult-files",
      ":map-keys-are-of-type-files",
      ":map-representation-files",
      ":map-unification-files",
      ":map-values-are-distinct-files",
      ":map-values-are-expression-list-of-usize-files",
      ":map-values-are-kresult-files",
      ":map-values-are-not-empty-files",
      ":map-values-are-of-type-files",
      ":map-values-become-keys-files",
      ":maps-are-reverse-files",
      ":no-map-key-in-list-files",
      ":map-values-are-below-limit-files",
      ":plistlen-functions-files",
      ":prepend-files",
      ":push-list-files",
      ":remove-first-files",
      ":remove-last-files",
      ":reverse-expression-csv-files",
      ":value-is-not-empty-files",
      ":value-not-in-map-values-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "keys-map-files",
  srcs = ["keys-map.k"],
  deps = [
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
  name = "list-elements-are-of-type-files",
  srcs = ["list-elements-are-of-type.k"],
  deps = [
      "//protocol-correctness/lib/language:type-reflection-files",
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
  name = "list-to-csv-files",
  srcs = ["list-to-csv.k"],
  deps = [
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
  name = "map-included-files",
  srcs = ["map-included.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-keys-are-below-limit-files",
  srcs = ["map-keys-are-below-limit.k"],
  deps = [
      ":map-keys-are-of-type-files",
      "//protocol-correctness/lib/language:cast-files",
      "//protocol-correctness/lib/proof/unsorted:formula-expansion-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-keys-are-kresult-files",
  srcs = ["map-keys-are-kresult.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-keys-are-of-type-files",
  srcs = ["map-keys-are-of-type.k"],
  deps = [
      "//protocol-correctness/lib/language:type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-representation-files",
  srcs = ["map-representation.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-unification-files",
  srcs = ["map-unification.k"],
  deps = [
      ":map-representation-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-are-below-limit-files",
  srcs = ["map-values-are-below-limit.k"],
  deps = [
      "//protocol-correctness/lib/language:cast-files",
      "//protocol-correctness/lib/proof/unsorted:formula-expansion-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-are-distinct-files",
  srcs = ["map-values-are-distinct.k"],
  deps = [
      ":value-not-in-map-values-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-are-expression-list-of-usize-files",
  srcs = ["map-values-are-expression-list-of-usize.k"],
  deps = [
      ":list-elements-are-usize-files",
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-are-kresult-files",
  srcs = ["map-values-are-kresult.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-are-not-empty-files",
  srcs = ["map-values-are-not-empty.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":value-is-not-empty-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-are-of-type-files",
  srcs = ["map-values-are-of-type.k"],
  deps = [
      "//protocol-correctness/lib/language:type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "map-values-become-keys-files",
  srcs = ["map-values-become-keys.k"],
  deps = [
      ":keys-map-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "maps-are-reverse-files",
  srcs = ["maps-are-reverse.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "no-map-key-in-list-files",
  srcs = ["no-map-key-in-list.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
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
  name = "remove-first-files",
  srcs = ["remove-first.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      "//protocol-correctness/lib/language:reflection-files",
      ":plistlen-functions-files",
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

klibrary(
  name = "value-is-not-empty-files",
  srcs = ["value-is-not-empty.k"],
  deps = [
      "//protocol-correctness/lib/language:type-reflection-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "value-not-in-map-values-files",
  srcs = ["value-not-in-map-values.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

