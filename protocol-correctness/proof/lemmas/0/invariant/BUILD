load("//:proof.bzl", "klibrary", "kprove_test", "ktrusted")

kprove_test(
  name = "lemma-map-keys-are-kresult-user-id-to-role",
  srcs = ["lemma-map-keys-are-kresult-user-id-to-role.k"],
  trusted = [
  ],
  semantics = "//protocol-correctness/proof/lemmas/0:lemmas-0-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-map-keys-are-kresult-user-id-to-role",
  srcs = ["lemma-map-keys-are-kresult-user-id-to-role.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-map-keys-are-kresult-user-id-to-role-files",
  srcs = [":trusted-lemma-map-keys-are-kresult-user-id-to-role"],
  deps = [
      "//protocol-correctness/proof:invariant-files",
      "//protocol-correctness/lib/functions:map-keys-are-kresult-files",
      ":trusted-lemma-map-keys-are-kresult-user-id-to-role",
  ],
  visibility = ["//visibility:public"],
)

