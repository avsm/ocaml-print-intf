# ocaml-print-intf

Pretty prints a compiled interface file into the corresponding human-readable
OCaml signature.

This is a convenient alternative to `ocamlc -i` which does this on source .ml
files.

## Example

On this repository:

```
$ dune build
$ dune exec -- ocaml-print-intf ./_build/default/.ocaml_print_intf.eobjs/byte/dune__exe__Ocaml_print_intf.cmt
val print_intf : string -> unit
val version : unit -> string
val usage : unit -> unit
```
