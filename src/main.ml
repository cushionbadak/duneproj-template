let input_file : string ref = ref ""
let flag_print_hello_world : bool ref = ref false
let flag_debug_mode : bool ref = ref false

let options : (Arg.key * Arg.spec * Arg.doc) list
= [
    ("-input", (Arg.String (fun s -> input_file := s)), "File path for input michelson program.");
    ("-hello", (Arg.Set flag_print_hello_world), "Print \"Hello World\" string before run the main program.");
    ("-debug", (Arg.Set flag_debug_mode), "Turn on debug mode. It will evaluates \"Printexc.record_backtrace true\". You can get exception-backtrace string by calling \"Printexc.get_backtrace ()\".");
  ]

let main : unit -> unit
=fun () -> begin
  let _ = print_endline "Main-Program Start" in
  let _ = 
    let f = IntCalc.Parse.parse_file !input_file in
    let vs : string = f |> IntCalc.Calculator.eval |> Stdlib.string_of_int in
    ("Calculation Result of \"" ^ (IntCalc.Calculator.formula_to_string f) ^ "\" is " ^ vs |> Stdlib.print_endline)
  in
  let _ = print_endline "Main-Program End" in
  ()
end

let _ = begin
  let usageMsg = "Usage: [PROGRAM-NAME] -input [filename]" in
  let _ = Arg.parse options (fun _ -> Stdlib.failwith "invalid option") usageMsg in
  
  try
    (* Option handler *)
    let _ : unit = if (!input_file) = "" then Stdlib.failwith "No Input File Option Given." else () in
    let _ : unit = if (!flag_print_hello_world) then print_endline "Hello World" else () in
    let _ : unit = if (!flag_debug_mode) then Printexc.record_backtrace true else () in
    (* Run the main function *)
    main ()
  with
  | exc -> Stdlib.prerr_endline (Printexc.to_string exc); Stdlib.prerr_endline (Printexc.get_backtrace())
end
