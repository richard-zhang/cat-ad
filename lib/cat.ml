(* f . g = b -> c . a -> b = a -> c*)
module type Cat = sig
  type ('a, 'b) arr

  val id : ('a, 'a) arr

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
  include Monoidal

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

  type num

  val negateC : (num, num) arr

  val addC : (num * num, num) arr

  val minusC : (num * num, num) arr

  val mulC : (num * num, num) arr
end

module type FloatingCat = sig
  type ('a, 'b) arr

  type num

  val sinC : (num, num) arr

  val cosC : (num, num) arr

  val expC : (num, num) arr

  val erfC : (num, num) arr

  val logC : (num, num) arr

  val recipeC : (num, num) arr
end

module type Scalable = sig
  type ('a, 'b) arr

  type num

  val scale : num -> (num, num) arr
end

module type AllCat = sig
  include Cat

  include Monoidal

  include Cartesian

  (* include CoCartesian *)

  (* include Closed with type ('a, 'b) arr := ('a, 'b) arr *)

  include ConstCat with type ('a, 'b) arr := ('a, 'b) arr
end


module type AllNumCat = sig
  include AllCat

  include NumCat with type ('a, 'b) arr := ('a, 'b) arr

  include FloatingCat with type num := num and type ('a, 'b) arr := ('a, 'b) arr

  include Scalable with type num := num and type ('a, 'b) arr := ('a, 'b) arr
end

module type FloatCat = AllNumCat with type num = float
