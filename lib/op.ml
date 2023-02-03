module ConstOps (M : Cat.ConstCat) = struct
  open M

  let const a = unitArrow a <.> it
end

module CartesianOps (M : Cat.Cartesian) = struct
  open M

  let tri f g = f <*> g <.> dup

  let fork (f, g) = tri f g

  let unfork f = (exl <.> f, exr <.> f)
end

module CoCartesianOps (M : Cat.CoCartesian) = struct
  open M

  let rev_tri f g = jam <.> (f <*> g)

  let join (f, g) = rev_tri f g

  let unjoin f = (f <.> inl, f <.> inr)
end

module FloatingCatOps (M : Cat.FloatCat) = struct
  open M
  let div = mulC <.> (id <*> recipeC)
end
