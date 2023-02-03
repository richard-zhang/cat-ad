(* f . g = b -> c . a -> b = a -> c*)
module type Cat = sig
  type ('a, 'b) arr

  val id : ('a, 'a) arr

  val ( <.> ) : ('b, 'c) arr -> ('a, 'b) arr -> ('a, 'c) arr
end

module type Monoidal = sig
  include Cat

  val ( <*> ) :
    ('a, 'c) arr -> ('b, 'd) arr -> ('a * 'b, 'c * 'd) arr
end

module type Cartesian = sig
  include Monoidal

  val exl : ('a * 'b, 'a) arr

  val exr : ('a * 'b, 'b) arr

  val dup : ('a, 'a * 'a) arr
end

module type CoCartesian = sig
  include Monoidal

  val inl : (float, float * float) arr

  val inr : (float, float * float) arr

  val jam : (float * float, float) arr
end

module type Terminal = sig
  include Cat

  val it : (float, unit) arr
end

(* module type Closed = sig
  include Cartesian

  val apply : ((float -> float) * float, float) arr

  val curry : (float * float, float) arr -> (float, float -> float) arr

  val uncurry : (float, float -> float) arr -> (float * float, float) arr
end *)

module type ConstCat = sig
  include Terminal

  val unitArrow : float -> (unit, float) arr
end

module type NumCat = sig
  type ('a, 'b) arr

  val negateC : (float, float) arr

  val addC : (float * float, float) arr

  val minusC : (float * float, float) arr

  val mulC : (float * float, float) arr
end

module type FloatingCat = sig
  type ('a, 'b) arr

  val sinC : (float, float) arr

  val cosC : (float, float) arr

  val expC : (float, float) arr

  val erfC : (float, float) arr

  val logC : (float, float) arr

  val recipeC : (float, float) arr
end

module type Scalable = sig
  type ('a, 'b) arr

  val scale : float -> (float, float) arr
end

module type AllCat = sig
  include Cat

  include Monoidal

  include Cartesian

  include CoCartesian with type ('a, 'b) arr := ('a, 'b) arr

  (* include Closed with type (float, float) arr := (float, float) arr *)

  include ConstCat with type ('a, 'b) arr := ('a, 'b) arr
end

module type FloatCat = sig
  include AllCat

  include NumCat with type ('a, 'b) arr := ('a, 'b) arr

  include FloatingCat with type ('a, 'b) arr := ('a, 'b) arr

  include Scalable with type ('a, 'b) arr := ('a, 'b) arr
end
