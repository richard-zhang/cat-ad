module Impl : Cat.FloatCat with type ('a, 'b) arr = 'a -> 'b = struct
  type ('a, 'b) arr = 'a -> 'b

  let id x = x

  let ( <.> ) f g x = f (g x)

  let ( <*> ) f g (x, y) = (f x, g y)

  let exl = fst

  let exr = snd

  let dup a = (a, a)

  let inl a = (a, 0.)

  let inr b = (0., b)

  let jam (a, b) = a +. b

  let it _ = ()

  (* let apply (f, a) = f a *)

  (* let curry f x y = f (x, y) *)

  (* let uncurry f (x, y) = (f x) y *)

  let unitArrow a () = a

  let negateC = Float.neg

  let addC (x, y) = Float.add x y

  let minusC (x, y) = x -. y

  let mulC (x, y) = Float.mul x y

  let recipeC x = Float.div 1.0 x

  let sinC = Float.sin

  let logC = Float.log

  let cosC = Float.cos

  let expC = Float.exp

  let erfC = Float.erf

  let scale a x = a *. x
end
