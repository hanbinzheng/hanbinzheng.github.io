---
title: The Central Limit Theorem
date: 2025-05-15 +0800
categories: [Math, Probability]
tags: [Probability, Math, CLT]
math: true
---

> Thanks to [子预](https://www.zhihu.com/people/thegenius-16). [His article](https://zhuanlan.zhihu.com/p/85233692) helped me a lot in understanding this topic. 

This is a brief (but not rigorous) proof of the **Central Limit Theorem (CLT)**.

The CLT is one of the most fundamental results in probability theory, showing that the sum of many independent random variables tends toward a normal distribution, regardless of their original distribution.

Intuitively, the CLT explains why many natural phenomena follow the bell curve: individual randomness averages out into a predictable pattern.

For application of CLT and some advanced understanding, I will add this part if available.

---

# The CLT Statement

Let $$X_1, X_2, \dots, X_n$$ be i.i.d. (independent and identically distributed) random variables with $$\mathbb{E}(X_j) = \mu$$ and $$\mathrm{Var}(X_j) = \sigma^2 < \infty$$.

Define:

$$
Z_n = \frac{\sum_{j=1}^n X_j - n\mu}{\sqrt{n} \cdot \sigma}
$$

Then for all $$\tau \in \mathbb{R}$$,

$$
\lim_{n \to \infty} \mathbb{P}(Z_n \leq \tau) = \Phi(\tau)
$$

Or equivalently,

$$
Z_n \xrightarrow{D} \mathcal{N}(0, 1)
$$


# Proof For Central Limit Theorem

## Notes

- This proof is sometimes called **Lindeberg–Lévy CLT**, requiring i.i.d. variables with finite variance.
- A more general version (Lindeberg–Feller CLT) loosens these assumptions.

---

## 1. The Road Map

To ensure both clarity and completeness, let’s first outline the proof strategy. We will use the characteristic function method to prove the CLT. The ideas are simple:

> 1. There's a one-to-one mapping relationship between characteristic function and pdf/distribution.
> 2. If the characteristic functions of $$Z_n$$ and $$\mathcal{N}(0,1)$$ are equal for all $$t$$, then their distributions are identical, which completes the proof.

For the **one-to-one mapping relationship**, we should turn to **Fourier Transform**. I will add this part if available in the future. In this blog, we assume that the previous relationship holds. For the definition and some properties of **Characteristic Function**, see [Appendix](#appendix-characteristic-functions) for reference.

---

## 2. Characteristic Function of $$\mathcal{N}(0, 1)$$

The definition of **Characteristic Function** for $$ \text{ random variable } X\, $$ is defined as follows:

$$
\varphi_X(t) = \mathbb{E}[e^{itX}]
$$

For standard Gaussian $$ \text{ random variable }  N \sim \mathcal{N}(0, 1) $$, we can obtain the **Characteristic Function** below:

$$
\begin{align*}
    \varphi_N(t) &= \int_{- \infty}^{+ \infty} e^{itx} \cdot \; \frac{1}{\sqrt{2 \pi}} e^{-\frac{1}{2} x^2} dx \\ \\
    &= \frac{1}{\sqrt{2 \pi}} \int_{- \infty}^{+ \infty} e^{-\frac{1}{2}x^2 \, + itx} dx \\ \\
    &= \frac{1}{\sqrt{2 \pi}} \int_{- \infty}^{+ \infty} e^{- \frac{1}{2}(x - it)^2 + \frac{1}{2}(it)^2} dx \\ \\
    &=  e^{- \frac{1}{2}t^2} \left( \frac{1}{\sqrt{2 \pi}} \int_{- \infty}^{+\infty} e^{- \frac{1}{2}(x - it)^2}d(x-it) \right) \\ \\
    &= e^{- \frac{1}{2} t^2}
    \end{align*}
$$

To evaluate the integral, we complete the square in the exponent.

For $$\frac{1}{\sqrt{2 \pi}} \int_{- \infty}^{+\infty} e^{- \frac{1}{2}(x - it)^2}d(x-it)$$, the resulting integral is the total probability under the standard normal distribution (after a complex shift), and therefore equals 1.

---

## 3. Characteristic Function of $$Z_n$$

### Step 1: Standardize Variables

Let's define standardized variables:

$$
Y_j = \frac{X_j - \mu}{\sigma}, \quad \text{so that } \mathbb{E}[Y_j] = 0, \quad \mathrm{Var}(Y_j) = 1
$$

Then:

$$
Z_n = \frac{1}{\sqrt{n}} \sum_{j=1}^n Y_j
$$

This reformulates the normalized sum into a simpler form, preparing it for the characteristic function method.

### Step 2: Characteristic Function of $$Y_j$$

The characteristic function of $$Y_j$$ is:

$$
\varphi_{Y_j}(t) = \mathbb{E}[e^{itY_j}]
$$

Using Taylor expansion:

$$
\begin{align*}
\varphi_{Y_j}(t) &= \mathbb{E}[\sum_{k=0}^{\infty} \frac{(itY_j)^k}{k !}]\\ \\
 &= \sum_{k=0}^{\infty} \frac{(it)^k}{k!} \mathbb{E}[Y_j^k] \\ \\
 &= 1 - \frac{1}{2} t^2 + o(t^2) \\
\end{align*}
$$

### Step 3: Characteristic Function of $$Z_n$$

Here are two properties of **Characteristic Function**:

> 1. Linearity: $$\text{ Linearity}: \;\varphi_{aX + b}(t) = e^{ibt} \cdot \varphi_X(at)$$
> 2. Independence: $$\text{If random variable } X \text{  and  } Y \text{ are independent }, \; \varphi_{X + Y}(t) = \varphi_X(t) \cdot \varphi_Y(t)$$

The proof for this two properites can be seen in the [Appendix](#appendix-characteristic-functions).

$$
\begin{align*}
\varphi_{Z_n}(t) &= \varphi_{\frac{1}{\sqrt{n}} \sum_j Y_j}(t) \\ \\
&= \left( \varphi_{Y_j} \left( \frac{t}{\sqrt{n}} \right) \right)^n \\ \\
&= \left(1 - \frac{t^2}{2n} + o\left( \frac{t^2}{n} \right) \right)^n \\
\end{align*}
$$

As $n \to \infty$, by the exponential limit identity:

$$
\lim_{n \to \infty} \varphi_{Z_n}(t) = \lim_{n \to \infty} \left(1 - \frac{t^2}{2n} + o\left(\frac{1}{n}\right)\right)^n = e^{- \frac{1}{2} t^2}
$$


## 4. Final Step

$$
\lim_{n \to \infty} \varphi_{Z_n}(t) = \varphi_{N}(t) \quad \Rightarrow \quad Z_n \xrightarrow{D} \mathcal{N}(0, 1) \quad \blacksquare
$$

This completes the proof of the Central Limit Theorem under the assumptions of i.i.d and finite variance.

---

# Appendix: Characteristic Functions

We only use 2 properities of Characteristic Functions. For more detailed description, please check [this article] (I will write this if available).


> 1. Linearity: $$\varphi_{aX + b}(t) = e^{ibt} \cdot \varphi_X(at)$$
> 2. Independence: $$\text{If random variable } X \text{ and } Y \text{ are independent }, \; \varphi_{X + Y}(t) = \varphi_X(t) \cdot \varphi_Y(t)$$

$$\text{Proof for Linearity}$$:

$$
\varphi_{aX+b} = \mathbb{E}[e^{it(aX+b)}] = e^{itb} \mathbb{E}[e^{itaX}] =e^{itb} \varphi_X(at)
$$

$$\text{Proof for Independence}$$:

This property is a consequence of the factorization of the joint distribution for independent random variables.

$$
\text{Suppose } \alpha(X) \text{ and } \beta(Y) \text{ are two functions of X and Y.}
$$

$$
\begin{align*}
\mathbb{E}[\alpha(X)\beta(Y)] &= \iint_{D_{X, Y}} f_{X, Y}(x, y) \cdot \alpha(x) \beta(y) \;dx \, dy \\
&= \iint_{D_{X, Y}} f_X(x) \, f_Y(y) \cdot \alpha(x) \beta(y) \;dx \, dy \\
&= \int_{D_X} f_X(x) \, \alpha(x) \, dx \; \cdot \; \int_{D_Y} f_Y(y)\, \beta(y) \, dy \\
&= \mathbb{E}[\alpha(X)] \, \cdot \, \mathbb{E}[\beta(Y)]
\end{align*}
$$

$$
\begin{aligned}
\varphi_{X + Y}(t) &= \mathbb{E}[e^{it(X + Y)}] \\ \\
&= \mathbb{E}[e^{itX}  e^{itY}] \\ \\ 
&= \mathbb{E}[e^{itX}] \, \mathbb{E}[e^{itY}] \\ \\ 
&= \varphi_X(t) \, \varphi_Y(t)
\end{aligned}
$$
