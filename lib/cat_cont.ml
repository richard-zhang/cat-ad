(* continuation category *)
module type ResType = sig
  type r
end

module Impl =
functor
  (Res : ResType)
  (C : Cat.FloatCat)
  ->
  struct
    open Res

    type ('a, 'b) arr = ('b, r) C.arr -> ('a, r) C.arr

    let id x = x

    (*
       ('b, 'c) arr = (c ~> r) -> (b ~> r)
       ('a, 'b) arr = (b ~> r) -> (a ~> r)
       ('a, 'c) arr = (c ~> r) -> (a ~> r)
    *)
    let ( <.> ) f g c2r = g (f c2r)
    (*
      given
       f = ('a, 'c) arr = (c ~> r) -> (a ~> r)
       g = ('b, 'd) arr = (d ~> r) -> (b ~> r)
      get
       ('a * 'b, 'c * 'd) arr = (c * d ~> r) -> (a * b ~> r)
       (f <*> g . )
    *)
    (* let ( <*> ) f g cd2r =  *)
  end
