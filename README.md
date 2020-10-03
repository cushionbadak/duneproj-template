# duneproj-template
Template for OCaml project using Dune build system. Appropriate for small ~ middle size project.


## Build & Run

Run below commands at the root directory of the project.

```
dune build
dune exec -- src/main.exe -help
dune exec -- src/main.exe -input benchmarks/hello.txt -hello -debug
```
