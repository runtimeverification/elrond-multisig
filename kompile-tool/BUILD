sh_binary(
  name = "kompile_tool",
  srcs = ["kompile.sh"],
  deps = [":k_release"],
  data = [":k_release"],
  visibility = ["//visibility:public"],
)

sh_binary(
  name = "kompile_e_tool",
  srcs = ["kompile-e.sh"],
  deps = [":k_release"],
  data = [":k_release"],
  visibility = ["//visibility:public"],
)

sh_binary(
  name = "kprove_kompile_tool",
  srcs = ["kprove-kompile.sh"],
  deps = [":k_release"],
  data = [":k_release"],
  visibility = ["//visibility:public"],
)

sh_binary(
  name = "kore_tool",
  srcs = ["kore.sh"],
  deps = [":k_release"],
  data = [":k_release"],
  visibility = ["//visibility:public"],
)

sh_binary(
  name = "kprovex_tool",
  srcs = ["kprovex.sh"],
  deps = [":k_release"],
  data = [":k_release"],
  visibility = ["//visibility:public"],
)

sh_binary(
  name = "ktrusted_tool",
  srcs = ["make-trusted.py"],
  visibility = ["//visibility:public"],
)

sh_binary(
  name = "kmerge_tool",
  srcs = ["kmerge.sh"],
  visibility = ["//visibility:public"],
)

sh_library(
  name = "k_release",
  data = glob(["k/bin/*", "k/include/**", "k/lib/kframework/**"]),
  visibility = ["//visibility:public"],
)

sh_library(
  name = "kast_script",
  srcs = ["kast.kscript"],
  visibility = ["//visibility:public"],
)

