# docker_optee_os_ci_clang

Dockerfile to run OP-TEE OS Continuous Integration, contains Clang downloaded
from the https://github.com/llvm/llvm-project release page.

The project was initially called docker_optee_os_ci_clangbuilt to reflect the
fact that Clang was built from source because released versions were not able
to build OP-TEE OS. Then the official 10.0 release came out and could be used.
Note that Clang has to be obtained from the LLVM project, not from the Ubuntu
distribution because three packages have to be merged (see get_clang.sh).
Therefore the project was renamed docker_optee_os_ci_clang. It remains
accessible using the old name.
