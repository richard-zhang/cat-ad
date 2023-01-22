open Cat

module Const (M : ConstCat) = struct
  open M

  let const a = unitArrow a <.> it
end
