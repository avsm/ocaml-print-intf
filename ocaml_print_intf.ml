(* Copyright (c) 2020 Anil Madhavapeddy <anil@recoil.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Format

let print_intf f =
  let {Cmi_format.cmi_sign;_} = Cmi_format.read_cmi f in
  Printtyp.signature std_formatter cmi_sign;
  print_flush ();
  print_newline ();
  flush stdout

let version () =  
  match Build_info.V1.version () with
  | None -> "n/a"
  | Some v -> Build_info.V1.Version.to_string v

let usage () =
  eprintf "%s <file>\n<file> can be a .cmi or .cmt or .cmti compiled with OCaml %s\n"
    Sys.argv.(0) Sys.ocaml_version

let () =
  match Sys.argv with
  | [| _; "--version" |] -> print_endline (version ())
  | [| _; file |] -> begin
     try print_intf file
     with Sys_error err -> prerr_endline err; exit 1
        | Cmi_format.Error _ -> prerr_endline "Error: not a valid .cmi .cmt or .cmti file"; exit 1
  end
  | _ -> usage (); exit 1
