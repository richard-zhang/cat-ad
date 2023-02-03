(* y = 1/(1 + e^(x_0 * x_1 + sin(x_0))) *)

module Formula1 =
functor
  (CAT : Cat.FloatCat)
  ->
  struct
    let value =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      let x_0_x_1 = mulC in
      let sin_x_0 = sinC <.> exl in
      let e_power = addC <.> fork (x_0_x_1, sin_x_0) in
      let e = expC <.> e_power in
      let incrment_one = addC <.> fork (e, const 1.0) in
      let final = div <.> fork (const 1.0, incrment_one) in
      final
  end

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
    let value : (CAT.num * CAT.num, CAT.num) CAT.arr =
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
    let value : (CAT.num * CAT.num, CAT.num) CAT.arr =
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
    let value : (CAT.num * CAT.num, CAT.num) CAT.arr =
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
    let value : (CAT.num * CAT.num, CAT.num) CAT.arr =
      let open CAT in
      let open Op.CartesianOps (CAT) in
      let open Op.ConstOps (CAT) in
      let open Op.FloatingCatOps (CAT) in
      let module F5 = Formula5(CAT) in
      let module F7 = Formula7(CAT) in
      recipeC <.> F5.value <.> F7.value
  end
