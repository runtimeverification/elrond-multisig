load("//:proof.bzl", "klibrary", "kompile", "kprove_test", "ktrusted")

kompile(
  name = "last-execute",
  srcs = ["last-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas:lemmas-execute-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "last-execute-files",
  srcs = ["last-execute.k"],
  deps = [
      "//protocol-correctness/proof/lemmas:lemmas-execute-files",
      "//protocol-correctness/proof/lemmas/list/plistlen:trusted-lemma-plistlen-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-last-to-start-kresult",
  srcs = ["lemma-last-to-start-kresult.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-last-to-start-kresult",
  srcs = ["lemma-last-to-start-kresult.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-last-to-start-kresult-files",
  srcs = [":trusted-lemma-last-to-start-kresult"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:last-to-start-files",
      ":trusted-lemma-last-to-start-kresult",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-last-to-start-usize",
  srcs = ["lemma-last-to-start-usize.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-last-to-start-usize",
  srcs = ["lemma-last-to-start-usize.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-last-to-start-usize-files",
  srcs = [":trusted-lemma-last-to-start-usize"],
  deps = [
      "//protocol-correctness/lib:last-to-start-files",
      "//protocol-correctness/lib:list-elements-are-usize-files",
      ":trusted-lemma-last-to-start-usize",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-last-usize",
  srcs = ["lemma-last-usize.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-last-usize",
  srcs = ["lemma-last-usize.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-last-usize-files",
  srcs = [":trusted-lemma-last-usize"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:list-elements-are-usize-files",
      ":trusted-lemma-last-usize",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-last",
  srcs = ["lemma-last.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-last",
  srcs = ["lemma-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-last-files",
  srcs = [":trusted-lemma-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      ":trusted-lemma-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-last-expression",
  srcs = ["lemma-pound-last-expression.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-last-expression",
  srcs = ["lemma-pound-last-expression.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-last-expression-files",
  srcs = [":trusted-lemma-pound-last-expression"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      ":trusted-lemma-pound-last-expression",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-last-usize-kitem",
  srcs = ["lemma-pound-last-usize-kitem.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-last-usize-kitem",
  srcs = ["lemma-pound-last-usize-kitem.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-last-usize-kitem-files",
  srcs = [":trusted-lemma-pound-last-usize-kitem"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:list-elements-are-usize-files",
      ":trusted-lemma-pound-last-usize-kitem",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-last-usize",
  srcs = ["lemma-pound-last-usize.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-last-usize",
  srcs = ["lemma-pound-last-usize.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-last-usize-files",
  srcs = [":trusted-lemma-pound-last-usize"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:list-elements-are-usize-files",
      ":trusted-lemma-pound-last-usize",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-last",
  srcs = ["lemma-pound-last.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-last",
  srcs = ["lemma-pound-last.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-last-files",
  srcs = [":trusted-lemma-pound-last"],
  deps = [
      "//protocol-correctness/lib:last-functions-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      ":trusted-lemma-pound-last",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-remove-last-kresult-expression",
  srcs = ["lemma-pound-remove-last-kresult-expression.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-remove-last-kresult-expression",
  srcs = ["lemma-pound-remove-last-kresult-expression.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-remove-last-kresult-expression-files",
  srcs = [":trusted-lemma-pound-remove-last-kresult-expression"],
  deps = [
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-pound-remove-last-kresult-expression",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-remove-last-kresult",
  srcs = ["lemma-pound-remove-last-kresult.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-remove-last-kresult",
  srcs = ["lemma-pound-remove-last-kresult.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-remove-last-kresult-files",
  srcs = [":trusted-lemma-pound-remove-last-kresult"],
  deps = [
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-pound-remove-last-kresult",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-pound-remove-last-usize",
  srcs = ["lemma-pound-remove-last-usize.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "3",
)

ktrusted(
  name = "trusted-lemma-pound-remove-last-usize",
  srcs = ["lemma-pound-remove-last-usize.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-pound-remove-last-usize-files",
  srcs = [":trusted-lemma-pound-remove-last-usize"],
  deps = [
      "//protocol-correctness/lib:list-elements-are-usize-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-pound-remove-last-usize",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-remove-last-kresult",
  srcs = ["lemma-remove-last-kresult.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-remove-last-kresult",
  srcs = ["lemma-remove-last-kresult.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-remove-last-kresult-files",
  srcs = [":trusted-lemma-remove-last-kresult"],
  deps = [
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-remove-last-kresult",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "lemma-remove-last-usize",
  srcs = ["lemma-remove-last-usize.k"],
  trusted = [
  ],
  semantics = "last-execute",
  breadth = "2",
)

ktrusted(
  name = "trusted-lemma-remove-last-usize",
  srcs = ["lemma-remove-last-usize.k"],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "trusted-lemma-remove-last-usize-files",
  srcs = [":trusted-lemma-remove-last-usize"],
  deps = [
      "//protocol-correctness/lib:list-elements-are-usize-files",
      "//protocol-correctness/lib:plistlen-functions-files",
      "//protocol-correctness/lib:remove-last-files",
      ":trusted-lemma-remove-last-usize",
  ],
  visibility = ["//visibility:public"],
)

