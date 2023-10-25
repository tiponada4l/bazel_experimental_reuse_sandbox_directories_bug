To reproduce:

```
$ bazel build --repo_env=CREATE_DIRECTORY=1 --experimental_reuse_sandbox_directories genrule
INFO: Analyzed target //:genrule (1 packages loaded, 3 targets configured).
INFO: Found 1 target...
Target //:genrule up-to-date:
  bazel-bin/out.txt
INFO: Elapsed time: 0.258s, Critical Path: 0.04s
INFO: 2 processes: 1 internal, 1 darwin-sandbox.
INFO: Build completed successfully, 2 total actions
$ bazel build --repo_env=CREATE_DIRECTORY=0 --experimental_reuse_sandbox_directories genrule
INFO: Analyzed target //:genrule (2 packages loaded, 4 targets configured).
INFO: Found 1 target...
ERROR: /Users/john/figma/experimental_reuse_sandbox_directories_bug/BUILD.bazel:1:8: Executing genrule //:genrule failed: I/O exception during sandboxed execution: /private/var/tmp/_bazel_john/9783db1df19336aed6f57df04766e276/sandbox/darwin-sandbox/18/execroot/__main__/external/repository/output (Directory not empty)
Target //:genrule failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 0.179s, Critical Path: 0.01s
INFO: 2 processes: 2 internal.
FAILED: Build did NOT complete successfully
```

Expected behavior: the second `bazel build` should succeed. (If you remove `--experimental_reuse_sandbox_directories`, or run `rm -rf "$(bazel info output_base)/sandbox/sandbox_stash"`, it does.)
