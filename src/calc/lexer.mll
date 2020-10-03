{
  open Parser
  open Lexing

  exception Lexing_error of string

  let keyword_table = [
    "+", PLUS;
    "-", MINUS;
    "*", ASTERISK;
    "/", SLASH;
  ]

  let get_keyword s = try List.assoc s keyword_table with _ -> Stdlib.raise (Lexing_error (s ^ " is not in Keyword List."))

  let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_bol = lexbuf.lex_curr_pos;
                pos_lnum = pos.pos_lnum + 1
      }
}

let digit = ['0' - '9']
let digits = digit+
let newline = '\r' | '\n' | "\r\n"
let blank = ' ' | '\t'

rule next_token = parse
  | '#'     {line_comment lexbuf}  (* comment *)
  | digits as s   {INT_VAL (Stdlib.int_of_string s)}
  | '('     {LPAREN}
  | ')'     {RPAREN}
  | eof     { EOF }
  | blank+  {next_token lexbuf}
  | newline {next_line lexbuf; next_token lexbuf}
  | _ as c  {get_keyword (String.make 1 c)}

(* Be aware of the wildcard-pattern's location. It should be at the end of the rule. *)
and line_comment = parse
  | newline {next_line lexbuf; next_token lexbuf}
  | eof     {EOF}
  | _       { line_comment lexbuf }
  