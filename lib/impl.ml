(* An implementation of  using vanilla ocaml function *)
module Vanilla : Cat.FloatCat with type ('a, 'b) arr = 'a -> 'b = struct
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

(* GAD (~>) a b = D (a -> b times (a ~> b)) *)

(* Generalized the linear map in the category of differentiable function *)

module GAD : functor (LM : Cat.FloatCat) ->
  Cat.FloatCat with type ('a, 'b) arr = 'a -> 'b * ('a, 'b) LM.arr =
functor
  (* module GAD = *)
(LM : Cat.FloatCat)
  ->
  struct
    type ('a, 'b) arr = 'a -> 'b * ('a, 'b) LM.arr

    let id a = (a, LM.id)

    let ( <.> ) f g x =
      let b, almb = g x in
      let c, blmc = f b in
      (c, LM.( <.> ) blmc almb)

    let ( <*> ) f g (x, y) =
      let b, almb = f x in
      let d, clmbd = g y in
      ((b, d), LM.( <*> ) almb clmbd)

    let exl (a, _) = (a, LM.exl)

    let exr (_, b) = (b, LM.exr)

    let dup a = ((a, a), LM.dup)

    let inl a = ((a, 0.), LM.inl)

    let inr b = ((0., b), LM.inr)

    let jam (a, b) = (a +. b, LM.jam)

    let it _ = ((), LM.it)

    let unitArrow a () = (a, LM.unitArrow 0.)

    let negateC a = (Float.neg a, LM.negateC)

    let addC (x, y) = (x +. y, LM.addC)

    let minusC (x, y) = (x -. y, LM.minusC)

    let mulC (a, b) =
      let dab = LM.( <*> ) (LM.scale b) (LM.scale a) in
      let comp = LM.( <.> ) LM.addC dab in
      (a *. b, comp)

    let scaleX f d x =
      let r = f x in
      (r, LM.scale (d x))

    let scaleR f d x =
      let r = f x in
      (r, LM.scale (d r))

    let recipeC = scaleR (fun x -> 1.0 /. x) (fun x -> Float.neg (x *. x))

    let sinC = scaleX Float.sin Float.cos

    let cosC = scaleX Float.cos (fun x -> Float.neg (Float.sin x))

    let logC = scaleX Float.log (fun x -> 1.0 /. x)

    let expC = scaleX Float.exp Float.exp

    let erfC =
      scaleX Float.erf (fun z ->
          Float.exp (Float.neg (z *. z)) *. (2.0 /. Float.sqrt Float.pi))

    let scale a x = (a *. x, LM.scale a)
  end

(* Generlaized Linear Map *)

(* Apply continuation to linear map *)
