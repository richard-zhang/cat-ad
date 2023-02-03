(* y = 1/(1 + e^(x_0 * x_1 + sin(x_0))) *)

module Formula2 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      mulC <.> (sinC <*> cosC)
  end

module Formula3 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value  =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      mulC <.> (cosC <*> id)
  end

module Formula4 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      mulC
  end

module Formula5 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      addC <.> tri (const 1.0) expC
  end

module Formula6 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      sinC <.> exl
  end

module Formula7 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value  =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      let module Sub = Formula6(CAT) in
      addC <.> tri mulC Sub.value
  end

module Formula8 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      let module F5 = Formula5(CAT) in
      let module F7 = Formula7(CAT) in
      recipeC <.> F5.value <.> F7.value
  end
