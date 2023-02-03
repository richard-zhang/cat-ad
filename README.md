# Project Plan

## First Commit
- [x] implement required module signature
- [x] implement a vanilla implementation
- [x] represent a formula using functor
- [x] evaluate the formula using ocaml category
## Second Commit
- [ ] implement the AAD version

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