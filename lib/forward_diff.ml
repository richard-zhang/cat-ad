open Formula
module ForwardDiff = Impl.GAD (Impl.Vanilla)

let%test_unit "eval_normal_function" =
  let module Example = Formula8 (Impl.Vanilla) in
  [%test_eq: Base.float] (Example.value (1.0, 1.0)) 0.13687741466075895

let%test_unit "eval_diff_2" =
  let module Diff2 = Formula2 (ForwardDiff) in
  let value, linearMap = Diff2.value (1.0, 1.0) in
  [%test_eq: Base.float] (linearMap (1.0, 0.0)) 0.2919265817264289;
  [%test_eq: Base.float] (linearMap (0.0, 1.0)) (-0.7080734182735712);
  [%test_eq: Base.float] value 0.45464871341284091

let%test_unit "eval_diff_3" =
  let module Diff3 = Formula3 (ForwardDiff) in
  let value, linearMap = Diff3.value (1.0, 1.0) in
  [%test_eq: Base.float] (linearMap (1.0, 0.0)) (Float.neg (Float.sin 1.));
  [%test_eq: Base.float] value (Float.cos 1.)

let%test_unit "eval_diff_4" =
  let module Diff4 = Formula4 (ForwardDiff) in
  let value, linearMap = Diff4.value (3.0, 8.0) in
  [%test_eq: Base.float] (linearMap (1.0, 0.0)) 8.0;
  [%test_eq: Base.float] (linearMap (0.0, 1.0)) 3.0;
  [%test_eq: Base.float] value 24.0

let%test_unit "eval_diff_5" =
  let module Diff = Formula5 (ForwardDiff) in
  let value, linearMap = Diff.value 3.0 in
  [%test_eq: Base.float] (linearMap 1.0) (Float.exp 3.0);
  [%test_eq: Base.float] value (1.0 +. Float.exp 3.0)

let%test_unit "eval_diff_6" =
  let module Diff6 = Formula6 (ForwardDiff) in
  let value, linearMap = Diff6.value (1.0, 1.0) in
  [%test_eq: Base.float] (linearMap (1.0, 0.0)) (Float.cos 1.);
  [%test_eq: Base.float] (linearMap (0.0, 1.0)) 0.0;
  [%test_eq: Base.float] value (Float.sin 1.)

let%test_unit "eval_diff_7" =
  let module Diff = Formula7 (ForwardDiff) in
  let value, linearMap = Diff.value (5.0, 3.0) in
  [%test_eq: Base.float] (linearMap (1.0, 0.0)) (3.0 +. Float.cos 5.0);
  [%test_eq: Base.float] (linearMap (0.0, 1.0)) 5.0;
  [%test_eq: Base.float] value ((5.0 *. 3.0) +. Float.sin 5.0)

let%test_unit "eval_diff_normal_function" =
  let module Diff1 = Formula8 (ForwardDiff) in
  let value, linearMap = Diff1.value (1.0, 1.0) in
  [%test_eq: Base.float] (linearMap (1.0, 0.0)) (-0.18197437656173132);
  [%test_eq: Base.float] (linearMap (0.0, 1.0)) (-0.11814198801654562);
  [%test_eq: Base.float] value 0.13687741466075895
