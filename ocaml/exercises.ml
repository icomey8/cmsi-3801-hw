exception Negative_Amount

let change (amount : int) : int list =
  if amount < 0 then
    raise Negative_Amount
  else if amount = 0 then
    [0; 0; 0; 0]  
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

  let first_then_apply (lst : 'a list) (predicate : 'a -> bool) (f : 'a -> 'b option) : 'b option =
    match List.find_opt predicate lst with
    | Some x -> f x  
    | None -> None   
  
  let lower (s : string) : string option = Some (String.lowercase_ascii s)

let rec int_pow (base : int) (exp : int) : int =
  if exp = 0 then 1
  else base * int_pow base (exp - 1)

let rec powers_generator (b : int) : int Seq.t =
  let rec aux n =
    fun () -> Seq.Cons (int_pow b n, aux (n + 1))
  in
  aux 0

let valid_line (line : string) : bool =
  let trimmed = String.trim line in
  String.length trimmed > 0 && trimmed.[0] <> '#'
  
let meaningful_line_count (filename : string) : int =
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

type 'a bst =
  | Empty
  | Node of 'a * 'a bst * 'a bst

let rec insert (x : 'a) (tree : 'a bst) : 'a bst =
  match tree with
  | Empty -> Node (x, Empty, Empty)
  | Node (v, left, right) ->
    if x < v then
      Node (v, insert x left, right)
    else if x > v then
      Node (v, left, insert x right)
    else
      tree  

let rec contains (x : 'a) (tree : 'a bst) : bool =
  match tree with
  | Empty -> false
  | Node (v, left, right) ->
    if x = v then true
    else if x < v then contains x left
    else contains x right

let rec inorder (tree : 'a bst) : 'a list =
  match tree with
  | Empty -> []
  | Node (v, left, right) -> (inorder left) @ [v] @ (inorder right)

let rec size (tree : 'a bst) : int =
  match tree with
  | Empty -> 0
  | Node (_, left, right) -> 1 + size left + size right
