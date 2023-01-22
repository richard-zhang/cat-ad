(* f . g = b -> c . a -> b = a -> c*)
module type Cat = sig
  type ('a, 'b) arr

  val ( <.> ) : ('b, 'c) arr -> ('a, 'b) arr -> ('a, 'c) arr
end

module type Monoidal = sig
  include Cat

  val ( <*> ) : ('a, 'c) arr -> ('b, 'd) arr -> ('a * 'b, 'c * 'd) arr
end

module type Cartesian = sig
  include Monoidal

  val exl : ('a * 'b, 'a) arr

  val exr : ('a * 'b, 'b) arr

  val dup : ('a, 'a * 'a) arr
end

module type CoCartesian = sig
  include Cat

  val inl : ('a, 'a * 'b) arr

  val inr : ('a, 'b * 'a) arr

  val jam : ('a * 'a, 'a) arr
end

module type Terminal = sig
  include Cat

  val it : ('a, unit) arr
end

module type Closed = sig
  include Cartesian

  val apply : (('a -> 'b) * 'a, 'b) arr

  val curry : ('a * 'b, 'c) arr -> ('a, 'b -> 'c) arr

  val uncurry : ('a, 'b -> 'c) arr -> ('a * 'b, 'c) arr
end

module type ConstCat = sig
  include Terminal

  val unitArrow : 'b -> (unit, 'b) arr
end

module type NumCat = sig
  type ('a, 'b) arr
  val negateC : ('a , 'a) arr
  val addC : ('a * 'a, 'a) arr
  val minusC : ('a * 'a, 'a) arr
  val mulC : ('a * 'a, 'a) arr
  val divC : ('a * 'a, 'a) arr
end

module type FloatingCat = sig
  type ('a, 'b) arr
  val sinC : ('a, 'a) arr
  val cosC : ('a, 'a) arr
end

