(* Naive Integer calculation *)
let rec eval : Formula.t -> int = function
| VAL n -> n
| ADD (f1, f2) -> (eval f1) + (eval f2)
| SUB (f1, f2) -> (eval f1) - (eval f2)
| MUL (f1, f2) -> (eval f1) * (eval f2)
| DIV (f1, f2) -> (eval f1) / (eval f2)

let rec formula_to_string : Formula.t -> string = 
  let fts f = formula_to_string f in
  function
  | VAL n -> Stdlib.string_of_int n
  | ADD (f1, f2) -> "(" ^ (fts f1) ^ "+" ^ (fts f2) ^ ")"
  | SUB (f1, f2) -> "(" ^ (fts f1) ^ "-" ^ (fts f2) ^ ")"
  | MUL (f1, f2) -> "(" ^ (fts f1) ^ "*" ^ (fts f2) ^ ")"
  | DIV (f1, f2) -> "(" ^ (fts f1) ^ "/" ^ (fts f2) ^ ")"
