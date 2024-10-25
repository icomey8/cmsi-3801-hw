exception Negative_Amount

let change (amount : int) : int list =
  if amount < 0 then
    raise Negative_Amount
  else if amount = 0 then
    [0; 0; 0; 0]  (* Special case for 0 *)
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux (remaining : int) (denoms : int list) : int list =
      match denoms with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations



let non_empty (s : string) : bool =
  String.length s > 0


let first_then_apply (lst : string list) (predicate : string -> bool) (f : string -> string) : string option =
  (* Use List.find_opt directly on predicate *)
  match List.find_opt predicate lst with
  | Some x -> Some (f x)  (* Apply  function if element is found *)
  | None -> None          (* Return None if no match is found *)

(* Transformation function *)
let lower (s : string) : string = String.lowercase_ascii s


(* Write your powers generator here *)
let rec int_pow (base : int) (exp : int) : int =
  if exp = 0 then 1
  else base * int_pow base (exp - 1)

let rec powers_generator (b : int) : int Seq.t =
  let rec aux n =
    fun () -> Seq.Cons (int_pow b n, aux (n + 1))
  in
  aux 0



(* Write your line count function here *)
  
  let valid_line (line : string) : bool =
    (* Trim whitespace *)
    let trimmed = String.trim line in
    (* Check if the line is non-empty*)
    String.length trimmed > 0 && trimmed.[0] <> '#'
  
  (* Function to count valid lines in a file *)
  let count_lines (filename : string) : int =
    (* Open and process the file *)
    let in_channel = open_in filename in
    Fun.protect
      (fun () ->
         let rec count acc =
           try
             let line = input_line in_channel in
             if valid_line line then count (acc + 1) else count acc
           with End_of_file -> acc
         in
         count 0
      )
      ~finally:(fun () -> close_in in_channel)
  

(* Write your shape type and associated functions here *)

type shape =
  | Box of float * float * float
  | Sphere of float

let volume (s : shape) : float =
  match s with
  | Box (w, h, d) -> w *. h *. d
  | Sphere r -> (4.0 /. 3.0) *. Float.pi *. r ** 3.0

let surface_area (s : shape) : float =
  match s with
  | Box (w, h, d) -> 2.0 *. ((w *. h) +. (w *. d) +. (h *. d))
  | Sphere r -> 4.0 *. Float.pi *. r ** 2.0

(* Write your binary search tree implementation here *)


type 'a bst =
  | Empty
  | Node of 'a * 'a bst * 'a bst

(* Inserts value into binary search tree *)
let rec insert (x : 'a) (tree : 'a bst) : 'a bst =
  match tree with
  | Empty -> Node (x, Empty, Empty)
  | Node (v, left, right) ->
    if x < v then
      Node (v, insert x left, right)
    else if x > v then
      Node (v, left, insert x right)
    else
      tree  (* If value is already present *)

(* Contains function*)
let rec contains (x : 'a) (tree : 'a bst) : bool =
  match tree with
  | Empty -> false
  | Node (v, left, right) ->
    if x = v then true
    else if x < v then contains x left
    else contains x right

(* In-order traversal*)
let rec inorder (tree : 'a bst) : 'a list =
  match tree with
  | Empty -> []
  | Node (v, left, right) -> (inorder left) @ [v] @ (inorder right)

(* Calculate size of tree *)
let rec size (tree : 'a bst) : int =
  match tree with
  | Empty -> 0
  | Node (_, left, right) -> 1 + size left + size right

