---
layout: post
title: The Central Limit Theorem
date: 2025-05-15 00:00:00+0800
description: A short proof of the Lindeberg–Lévy central limit theorem using characteristic functions.
tags: [probability, gaussian]
categories: math
toc:
  sidebar: left
---

> Thanks to [子预](https://www.zhihu.com/people/thegenius-16). [His article](https://zhuanlan.zhihu.com/p/85233692) helped me a lot in understanding this topic.

This post gives a short, mostly self-contained proof of the **Central Limit Theorem (CLT)**. It is not fully rigorous: I state two standard results from analysis without proving them.

The CLT is one of the most important results in probability theory. It says that the normalized sum of many independent random variables tends to a normal distribution, whatever the distribution of each variable is. This is why the bell curve shows up so often in nature: many small, independent sources of randomness add up to a predictable pattern.

---

## The statement

**Theorem (Lindeberg–Lévy CLT).** Let $$X_1, X_2, \dots$$ be i.i.d. (independent and identically distributed) random variables with $$\mathbb{E}[X_j] = \mu$$ and $$\mathrm{Var}(X_j) = \sigma^2$$, where $$0 < \sigma^2 < \infty$$. Define

$$
Z_n = \frac{\sum_{j=1}^n X_j - n\mu}{\sigma\sqrt{n}} .
$$

Then for every $$\tau \in \mathbb{R}$$,

$$
\lim_{n \to \infty} \mathbb{P}(Z_n \leq \tau) = \Phi(\tau) = \int_{-\infty}^{\tau} \frac{1}{\sqrt{2\pi}} e^{-x^2/2} \, dx ,
$$

or, equivalently, $$Z_n \xrightarrow{D} \mathcal{N}(0, 1)$$.

**Notes.**

- The name _Lindeberg–Lévy_ refers to this version of the theorem, which needs i.i.d. variables with finite variance.
- A more general version, the _Lindeberg–Feller_ CLT, drops the "identically distributed" assumption and replaces it with the weaker Lindeberg condition.

---

## 1. The road map

We use **characteristic functions**. The characteristic function of a random variable $$X$$ is

$$
\varphi_X(t) = \mathbb{E}\left[e^{itX}\right], \qquad t \in \mathbb{R}.
$$

It always exists, because $$\lvert e^{itX} \rvert = 1$$. The proof rests on two classical facts, which I state without proof:

> 1. **Uniqueness.** The characteristic function determines the distribution: if $$\varphi_X(t) = \varphi_Y(t)$$ for all $$t$$, then $$X$$ and $$Y$$ have the same distribution. (This is the Fourier inversion theorem in disguise.)
> 2. **Lévy's continuity theorem.** If $$\varphi_{Z_n}(t) \to \varphi_Z(t)$$ for every $$t$$, then $$Z_n \xrightarrow{D} Z$$.

Uniqueness alone is not enough. We never have $$\varphi_{Z_n} = \varphi_N$$ exactly for a finite $$n$$, so we need the continuity theorem to turn _pointwise convergence_ of characteristic functions into convergence in distribution.

So the plan is:

1. compute the characteristic function of $$N \sim \mathcal{N}(0,1)$$;
2. show that $$\varphi_{Z_n}(t) \to \varphi_N(t)$$ for every $$t$$;
3. apply Lévy's continuity theorem.

We use two simple properties of characteristic functions, which are proved in the [appendix](#appendix-two-properties-of-characteristic-functions):

> 1. **Affine maps:** $$\varphi_{aX + b}(t) = e^{ibt} \, \varphi_X(at)$$.
> 2. **Independence:** if $$X$$ and $$Y$$ are independent, then $$\varphi_{X + Y}(t) = \varphi_X(t) \, \varphi_Y(t)$$.

---

## 2. The characteristic function of $$\mathcal{N}(0, 1)$$

Let $$N \sim \mathcal{N}(0, 1)$$. We want to show

$$
\varphi_N(t) = \int_{-\infty}^{+\infty} e^{itx} \, \frac{1}{\sqrt{2\pi}} e^{-x^2/2} \, dx = e^{-t^2/2}.
$$

**The quick (heuristic) way.** Complete the square in the exponent:

$$
\begin{align*}
\varphi_N(t)
&= \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{+\infty} e^{-\frac{1}{2}x^2 + itx} \, dx \\[1ex]
&= \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{+\infty} e^{-\frac{1}{2}(x - it)^2 + \frac{1}{2}(it)^2} \, dx \\[1ex]
&= e^{-\frac{1}{2}t^2} \cdot \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{+\infty} e^{-\frac{1}{2}(x - it)^2} \, dx .
\end{align*}
$$

The remaining integral is the Gaussian integral shifted by the imaginary constant $$it$$. It still equals $$\sqrt{2\pi}$$, but justifying this requires contour integration (Cauchy's theorem). A plain real change of variables does not work.

**A rigorous way without complex analysis.** Since $$\mathbb{E}\lvert N \rvert < \infty$$, we may differentiate under the integral sign:

$$
\begin{align*}
\varphi_N'(t)
&= \int_{-\infty}^{+\infty} ix \, e^{itx} \, \frac{1}{\sqrt{2\pi}} e^{-x^2/2} \, dx \\[1ex]
&= \frac{i}{\sqrt{2\pi}} \int_{-\infty}^{+\infty} e^{itx} \, d\!\left(-e^{-x^2/2}\right) \\[1ex]
&= \frac{i}{\sqrt{2\pi}} \left( \Big[-e^{itx} e^{-x^2/2}\Big]_{-\infty}^{+\infty} + \int_{-\infty}^{+\infty} it \, e^{itx} e^{-x^2/2} \, dx \right) \\[1ex]
&= -t \, \varphi_N(t).
\end{align*}
$$

This is a first-order linear ODE with $$\varphi_N(0) = 1$$. Its unique solution is $$\varphi_N(t) = e^{-t^2/2}$$.

---

## 3. The characteristic function of $$Z_n$$

### Step 1: standardize

Define the standardized variables

$$
Y_j = \frac{X_j - \mu}{\sigma}, \qquad \text{so that} \quad \mathbb{E}[Y_j] = 0, \quad \mathbb{E}[Y_j^2] = \mathrm{Var}(Y_j) = 1 .
$$

Then

$$
Z_n = \frac{1}{\sqrt{n}} \sum_{j=1}^n Y_j .
$$

The $$Y_j$$ are still i.i.d., so they share one characteristic function, which we write as $$\varphi_Y$$.

### Step 2: expand $$\varphi_Y$$ near zero

The original version of this post expanded $$e^{itY}$$ as an infinite Taylor series and swapped $$\mathbb{E}$$ with the sum. That is not allowed here, because it needs **all** moments of $$Y$$ to exist, and we only assumed a finite second moment.

The correct tool is a second-order expansion. Since $$\mathbb{E}[Y^2] < \infty$$, $$\varphi_Y$$ is twice continuously differentiable, with

$$
\varphi_Y(0) = 1, \qquad
\varphi_Y'(0) = i\,\mathbb{E}[Y] = 0, \qquad
\varphi_Y''(0) = -\mathbb{E}[Y^2] = -1 .
$$

Taylor's theorem then gives

$$
\varphi_Y(t) = 1 - \frac{t^2}{2} + o(t^2) \qquad \text{as } t \to 0 .
$$

### Step 3: multiply

By the two properties of characteristic functions (independence, then the affine map with $$a = 1/\sqrt{n}$$, $$b = 0$$):

$$
\begin{align*}
\varphi_{Z_n}(t)
&= \varphi_{\sum_j Y_j}\!\left( \frac{t}{\sqrt{n}} \right)
= \left( \varphi_Y\!\left( \frac{t}{\sqrt{n}} \right) \right)^n \\[1ex]
&= \left( 1 - \frac{t^2}{2n} + o\!\left( \frac{1}{n} \right) \right)^n \qquad (n \to \infty,\ t \text{ fixed}).
\end{align*}
$$

### Step 4: take the limit

For fixed $$t$$, write $$c_n = n\left(\varphi_Y(t/\sqrt{n}) - 1\right)$$. The expansion above shows $$c_n \to -t^2/2$$. A standard fact (which also holds for complex $$c_n$$) is

$$
c_n \to c \quad \Longrightarrow \quad \left( 1 + \frac{c_n}{n} \right)^n \to e^{c} .
$$

Therefore

$$
\lim_{n \to \infty} \varphi_{Z_n}(t) = e^{-t^2/2} = \varphi_N(t) \qquad \text{for every } t \in \mathbb{R} .
$$

---

## 4. Conclusion

We have shown that $$\varphi_{Z_n}(t) \to \varphi_N(t)$$ for every $$t$$, and $$\varphi_N$$ is the characteristic function of $$\mathcal{N}(0,1)$$. By Lévy's continuity theorem,

$$
Z_n \xrightarrow{D} \mathcal{N}(0, 1) . \qquad \blacksquare
$$

This completes the proof of the CLT for i.i.d. variables with finite, nonzero variance.

---

## Appendix: two properties of characteristic functions

**Affine maps.** For constants $$a, b \in \mathbb{R}$$,

$$
\varphi_{aX+b}(t) = \mathbb{E}\left[e^{it(aX+b)}\right] = e^{itb} \, \mathbb{E}\left[e^{i(ta)X}\right] = e^{itb} \, \varphi_X(at) .
$$

**Independence.** If $$X$$ and $$Y$$ are independent with densities $$f_X, f_Y$$, their joint density factors as $$f_{X,Y}(x, y) = f_X(x) f_Y(y)$$. So for any (bounded, measurable) functions $$\alpha$$ and $$\beta$$,

$$
\begin{align*}
\mathbb{E}[\alpha(X)\beta(Y)]
&= \iint f_{X,Y}(x, y) \, \alpha(x) \beta(y) \, dx \, dy \\[1ex]
&= \iint f_X(x) f_Y(y) \, \alpha(x) \beta(y) \, dx \, dy \\[1ex]
&= \int f_X(x) \, \alpha(x) \, dx \cdot \int f_Y(y) \, \beta(y) \, dy \\[1ex]
&= \mathbb{E}[\alpha(X)] \cdot \mathbb{E}[\beta(Y)] .
\end{align*}
$$

The same identity holds without densities, but it is easiest to see in this case. Taking $$\alpha(x) = e^{itx}$$ and $$\beta(y) = e^{ity}$$,

$$
\varphi_{X + Y}(t) = \mathbb{E}\left[e^{itX} e^{itY}\right] = \mathbb{E}\left[e^{itX}\right] \mathbb{E}\left[e^{itY}\right] = \varphi_X(t) \, \varphi_Y(t) .
$$

By induction, the characteristic function of a sum of $$n$$ independent variables is the product of their characteristic functions.
