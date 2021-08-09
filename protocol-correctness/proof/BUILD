load("//:proof.bzl", "klibrary", "kompile")

kompile(
  name = "main-proof-execute",
  srcs = ["main-proof-execute.k"],
  deps = [
      ":lemmas-files",
      ":main-proof-execute-no-lemmas-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "main-proof-execute-files",
  srcs = ["main-proof-execute.k"],
  deps = [
      ":lemmas-files",
      ":main-proof-execute-no-lemmas-files",
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
      "//protocol-correctness/lib:list-elements-are-usize-files",
      "//protocol-correctness/lib:list-elements-are-distinct-files",
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
      "//protocol-correctness/lib:base-types-files",
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
      ":instrumentation-map-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "invariant-files",
  srcs = ["invariant.k"],
  deps = [
      ":execution-proof-helpers-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "lemmas-files",
  srcs = ["lemmas.k"],
  deps = [
      "//protocol-correctness/proof/lemmas/int:trusted-lemma-add-one-if-not-negative-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-last-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-last-usize-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-last-to-start-kresult-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-last-to-start-usize-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-last-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-last-expression-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-last-usize-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-last-usize-kitem-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-remove-last-kresult-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-remove-last-kresult-expression-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-pound-remove-last-usize-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-remove-last-kresult-files",
      "//protocol-correctness/proof/lemmas/list/last:trusted-lemma-remove-last-usize-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "main-proof-execute-no-lemmas-files",
  srcs = ["main-proof-execute-no-lemmas.k"],
  deps = [
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
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

