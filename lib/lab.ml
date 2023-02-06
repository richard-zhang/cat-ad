module type Additive = sig
  type t

  val zero : t

  val add : t -> t -> t
end

module Additive_float : Additive with type t = float = struct
  type t = float

  let zero = 0.

  let add = ( +. )
end

(* hardcoded the default constraint to be Additive *)

type 'a additive = (module Additive with type t = 'a)

module type Cat = sig
  (* type 'a obj_const *)
  type ('a, 'b) arr

  val id : 'a additive -> ('a, 'a) arr

  val ( <.> ) :
    'a additive * 'b additive * 'c additive ->
    ('b, 'c) arr ->
    ('a, 'b) arr ->
    ('a, 'c) arr
end

module type CoCartesian = sig
  include Cat

  val inl : 'b additive -> ('a, 'a * 'b) arr

  val inr : 'a additive -> ('b, 'a * 'b) arr

  (* val jam : 'a additive -> ('a * 'a, 'a) arr *)
end

module Cat_Impl : Cat with type ('a, 'b) arr = 'a -> 'b = struct
  type ('a, 'b) arr = 'a -> 'b

  let id _ x = x

  let ( <.> ) _ f g x = f (g x)
end

module CoCartesian_Impl : CoCartesian with type ('a, 'b) arr = 'a -> 'b = struct
  type ('a, 'b) arr = 'a -> 'b

  let id _ x = x

  let ( <.> ) _ f g x = f (g x)

  let inl : 'b additive -> ('a, 'a * 'b) arr =
    fun (type b) (additive_impl : b additive) x ->
     let module M = (val additive_impl : Additive with type t = b) in
     (x, M.zero)

  let inr : 'b additive -> ('a, 'b * 'a) arr =
    fun (type b) (additive_impl : b additive) x ->
     let module M = (val additive_impl : Additive with type t = b) in
     (M.zero, x)
  (* let inr = fun (type a) (additive_impl : a additive) x = (additive_impl.zero, x)
     let jam = fun (type a) (additive_impl : a additive) (x, x) = additive_impl.add x x *)
end

(* module type CoCartesian = sig *)
(* include  *)
(* end *)

(* A functor that take any module type *)
