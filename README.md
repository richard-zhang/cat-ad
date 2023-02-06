# Project Plan

## First Milestone
- [x] implement required module signature
- [x] implement a vanilla implementation
- [x] represent a formula using functor
- [x] evaluate the formula using ocaml category
## Second Milestone
- [x] replace additive type with float
  * in order to deal with generic zero object issue
  * I choose not to have parameterized type and use float only
    * 0.0 is zero object
- [x] implement the forward AAD version
## Airport Milestone
- [x] airport_typeclass: compare haskell type class vs ocaml modular
- [x] haskell foundation: type class/type family
- [x] basic Haskell type class trick
- [x] concat implementation on Additive constraints
- [x] hacking solution to introduce additive
## X Milestone
- [ ] represent linear map as generalized matrices
- [ ] represent linear map as continuation of linear map
- [ ] RAD implementation

## Helper function

* linear map: scale (d x r)
* scalarD
```hs
scalarD f d = D (\x -> let r = f x in (r, scale (d x r)))
```
* scalarR f d = scalarD f (const d)
  * const :: a -> b -> a
  * d :: (s -> s)
  * target :: s -> (s -> s)
  * const :: (s -> s) -> s -> (s -> s)
  * const d :: s -> (s -> s)
  * (const d) x r = d r
$$
\frac{d(\frac{1}{x})}{dx} = -(\frac{1}{x})^2
$$
* scalarX f d = scalarD f (const . d)
  * const :: a -> b -> a
  * (.) :: (b -> c) -> (a -> b) -> (a -> c)
  * d :: s -> s
  * (.) :: (s -> (s -> s)) -> (s -> s) -> (s -> (s -> s))
  * const :: s -> (s -> s)
  * (const . d) :: s -> (s -> s)
  * (const . d) x r = ((const . d) x) r = (const (d x)) r = d x

$$
\frac{d(cos(x))}{x} = - sin(x)
$$

*
$$
\begin{aligned}
d(a/b) &= \frac{a'b -ab'}{b^2}\\
D_(x * y) (a, b) (da, db) &=  a\times db + b \times da \\
D_(x * \frac{1}{y}) (a, \frac{1}{b}) (da, d(\frac{1}{b})) &= a \times d(\frac{1}{b}) + \frac{1}{b} \times da\\
& = - a \times db \frac{1}{b^2} + \frac{da\times b}{b^2} \\
& = \frac{da\times b - db\times a}{b^2}
\end{aligned}
$$

* chain rule
$$
D(f . g) (a) = Df(g(a)). Dg(a)
$$