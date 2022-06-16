load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "main-proof-execute",
  srcs = ["main-proof-execute.k"],
  deps = [
      "//protocol-correctness/lib/proof/induction:induction-files",
      "//protocol-correctness/lib/proof/unsorted:equality-without-substitution-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      ":base-files",
      ":execution-proof-helpers-files",
      ":instrumentation-change-user-role-files",
      ":instrumentation-concretize-files",
      ":instrumentation-discard-action-files",
      ":instrumentation-functions-files",
      ":instrumentation-lemma-files",
      ":instrumentation-map-files",
      ":instrumentation-perform-action-add-proposer-files",
      ":instrumentation-perform-action-endpoint-files",
      ":instrumentation-perform-action-remove-user-files",
      ":instrumentation-perform-action-sc-deploy-files",
      ":instrumentation-perform-split-action-files",
      ":instrumentation-proof-files",
      ":instrumentation-propose-sc-deploy-files",
      ":instrumentation-sign-files",
      ":instrumentation-unsign-files",
      "//protocol-correctness/proof/instrumentation/pushlist:pushlist-instrumentation-files",
      ":invariant-files",
      "//protocol-correctness/proof/named-lemmas:named-lemmas-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "main-proof-execute-files",
  srcs = ["main-proof-execute.k"],
  deps = [
      "//protocol-correctness/lib/proof/induction:induction-files",
      "//protocol-correctness/lib/proof/unsorted:equality-without-substitution-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      ":base-files",
      ":execution-proof-helpers-files",
      ":instrumentation-change-user-role-files",
      ":instrumentation-concretize-files",
      ":instrumentation-discard-action-files",
      ":instrumentation-functions-files",
      ":instrumentation-lemma-files",
      ":instrumentation-map-files",
      ":instrumentation-perform-action-add-proposer-files",
      ":instrumentation-perform-action-endpoint-files",
      ":instrumentation-perform-action-remove-user-files",
      ":instrumentation-perform-action-sc-deploy-files",
      ":instrumentation-perform-split-action-files",
      ":instrumentation-proof-files",
      ":instrumentation-propose-sc-deploy-files",
      ":instrumentation-sign-files",
      ":instrumentation-unsign-files",
      "//protocol-correctness/proof/instrumentation/pushlist:pushlist-instrumentation-files",
      ":invariant-files",
      "//protocol-correctness/proof/named-lemmas:named-lemmas-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "base-files",
  srcs = ["base.k"],
  deps = [
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "execution-proof-helpers-files",
  srcs = ["execution-proof-helpers.k"],
  deps = [
      "//protocol-correctness/lib/functions:all-keys-become-keys-files",
      "//protocol-correctness/lib/functions:list-elements-are-usize-files",
      "//protocol-correctness/lib/functions:list-elements-are-distinct-files",
      "//protocol-correctness/lib/functions:list-to-map-set-files",
      "//protocol-correctness/lib/functions:map-included-files",
      "//protocol-correctness/lib/functions:map-keys-are-below-limit-files",
      "//protocol-correctness/lib/functions:map-values-are-below-limit-files",
      "//protocol-correctness/lib/functions:map-values-become-keys-files",
      "//protocol-correctness/lib/functions:no-map-key-in-list-files",
      "//protocol-correctness/lib/functions:push-list-files",
      "//protocol-correctness/lib/functions:value-not-in-map-values-files",
      "//protocol-correctness/lib/language:cast-files",
      "//protocol-correctness/lib/proof/unsorted:formula-expansion-files",
      ":base-files",
      "//protocol-correctness/proof/map:map-execute-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-change-user-role-files",
  srcs = ["instrumentation-change-user-role.k"],
  deps = [
      ":instrumentation-map-files",
      ":instrumentation-perform-split-action-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-concretize-files",
  srcs = ["instrumentation-concretize.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-discard-action-files",
  srcs = ["instrumentation-discard-action.k"],
  deps = [
      ":execution-proof-helpers-files",
      ":instrumentation-map-files",
      ":instrumentation-proof-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-functions-files",
  srcs = ["instrumentation-functions.k"],
  deps = [
      ":instrumentation-proof-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-lemma-files",
  srcs = ["instrumentation-lemma.k"],
  deps = [
      "//protocol-correctness/lib/language:base-types-files",
      ":instrumentation-concretize-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-map-files",
  srcs = ["instrumentation-map.k"],
  deps = [
      ":instrumentation-proof-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-perform-action-add-proposer-files",
  srcs = ["instrumentation-perform-action-add-proposer.k"],
  deps = [
      ":instrumentation-map-files",
      ":instrumentation-perform-split-action-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-perform-action-endpoint-files",
  srcs = ["instrumentation-perform-action-endpoint.k"],
  deps = [
      ":execution-proof-helpers-files",
      ":instrumentation-perform-split-action-files",
      ":instrumentation-proof-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-perform-action-remove-user-files",
  srcs = ["instrumentation-perform-action-remove-user.k"],
  deps = [
      ":instrumentation-map-files",
      ":instrumentation-perform-split-action-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-perform-action-sc-deploy-files",
  srcs = ["instrumentation-perform-action-sc-deploy.k"],
  deps = [
      ":instrumentation-map-files",
      ":instrumentation-perform-split-action-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-perform-split-action-files",
  srcs = ["instrumentation-perform-split-action.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
      ":instrumentation-concretize-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-proof-files",
  srcs = ["instrumentation-proof.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
      ":instrumentation-concretize-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-propose-sc-deploy-files",
  srcs = ["instrumentation-propose-sc-deploy.k"],
  deps = [
      ":instrumentation-proof-files",
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-sign-files",
  srcs = ["instrumentation-sign.k"],
  deps = [
      "//protocol-correctness/lib/functions:list-first-with-default-files",
      ":instrumentation-map-files",
      "//protocol-correctness:pseudocode-files",
      "//protocol-correctness/proof/instrumentation/pushlist:pushlist-instrumentation-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "instrumentation-unsign-files",
  srcs = ["instrumentation-unsign.k"],
  deps = [
      "//protocol-correctness/lib/functions:concretize-expression-list-files",
      ":instrumentation-map-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "invariant-files",
  srcs = ["invariant.k"],
  deps = [
      "//protocol-correctness/lib/functions:list-elements-are-distinct-files",
      "//protocol-correctness/lib/functions:list-elements-are-usize-files",
      "//protocol-correctness/lib/functions:map-keys-are-below-limit-files",
      "//protocol-correctness/lib/functions:map-keys-are-of-type-files",
      "//protocol-correctness/lib/functions:map-values-are-expression-list-of-usize-files",
      "//protocol-correctness/lib/functions:map-values-are-kresult-files",
      "//protocol-correctness/lib/functions:map-values-are-not-empty-files",
      "//protocol-correctness/lib/functions:map-values-are-of-type-files",
      "//protocol-correctness/lib/functions:maps-are-reverse-files",
      "//protocol-correctness/lib/functions:value-is-not-empty-files",
      "//protocol-correctness/lib/functions:value-not-in-map-values-files",
      "//protocol-correctness/multisig/lib/language:type-reflection-files",
      ":execution-proof-helpers-files",
      "//protocol-correctness/proof/map:map-execute-files",
  ],
  visibility = ["//visibility:public"],
)

