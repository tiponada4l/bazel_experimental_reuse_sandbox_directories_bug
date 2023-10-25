def _impl(repository_ctx):
    create_directory = repository_ctx.os.environ.get("CREATE_DIRECTORY", "0")
    if create_directory == "1":
        repository_ctx.execute(["mkdir", "-p", "output"])
        repository_ctx.execute(["touch", "output/file"])
        repository_ctx.file(
            "BUILD.bazel",
            """filegroup(
    name = "repository",
    srcs = glob(["output/**"]),
    visibility = ["//visibility:public"],
)
""",
        )
    else:
        repository_ctx.execute(["touch", "output"])
        repository_ctx.file(
            "BUILD.bazel",
            """filegroup(
    name = "repository",
    srcs = ["output"],
    visibility = ["//visibility:public"],
)
""",
        )

repository = repository_rule(
    implementation = _impl,
    environ = ["CREATE_DIRECTORY"],
)
