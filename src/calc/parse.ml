let print_position outx lexbuf =
  let open Lexing in
  let pos = lexbuf.lex_curr_p in
  Printf.fprintf outx "%s:%d:%d" pos.pos_fname pos.pos_lnum
    (pos.pos_cnum - pos.pos_bol + 1)

let parse_file : string -> Formula.t = fun filename -> 
  let in_c = Stdlib.open_in filename in
  let lexbuf = Lexing.from_channel in_c in
  try
    let res = Parser.start Lexer.next_token lexbuf in
    let () = close_in in_c in
    res
  with
  | Lexer.Lexing_error msg as e ->    (* Error defined at lexer.mll *)
      Printf.fprintf stderr "%a: %s\n" print_position lexbuf msg;
      close_in in_c;
      raise e
  | Parser.Error as e ->    (* menhir built-in exception. So parser.mly can omit this. *)
      Printf.fprintf stderr "%s%a: syntax error\n" filename print_position lexbuf;
      close_in in_c;
      raise e
