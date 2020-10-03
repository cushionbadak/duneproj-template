(* see menhir manual to see this mly grammar *)
%{
  open Formula

  (* "https://github.com/kupl/MicSE/blob/master/src/pre/lib/parser.mly"
      has a good solution to calculate to get line & column position value.
  *)

%}

%token <int> INT_VAL
%token PLUS MINUS ASTERISK SLASH LPAREN RPAREN
%token EOF

%start <Formula.t> start


%%

(* For detailed example of precedence grammar implementation, see "https://stackoverflow.com/a/4977462/10353572" *)

start:
  | f=fm EOF {f}

fm:
  | f1=fm PLUS f2=fm_high_precedence {ADD(f1,f2)}
  | f1=fm MINUS f2=fm_high_precedence {SUB(f1,f2)}
  | f=fm_high_precedence {f}

fm_high_precedence:
  | f1=fm_high_precedence ASTERISK f2=fm_terminal {MUL(f1,f2)}
  | f1=fm_high_precedence SLASH f2=fm_terminal {DIV(f1,f2)}
  | f=fm_terminal {f}

fm_terminal:
  | n=INT_VAL {VAL n}
  | LPAREN f=fm RPAREN {f}
