---
layout: post
title: The Gaussian Integral
date: 2025-05-19 00:00:00+0800
description: From the one-dimensional Gaussian integral to the multivariate case, with a probabilistic and linear-algebraic view.
tags: [probability, gaussian, linear-algebra, pca]
categories: math
toc:
  sidebar: left
---

> This post introduces the Gaussian integral, starting from basic integration and building up to a probabilistic and linear-algebraic view of it.

## I. The fundamental integral

The most basic Gaussian integral is

$$
\int_{-\infty}^{\infty} \exp \left(-\frac{1}{2}x^2 \right) dx = \sqrt{2\pi} ,
$$

or equivalently, in the form of the **standard Gaussian density**,

$$
\frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} x^2 \right) dx = 1 .
$$

Here is how to compute it. Write $$I$$ for the integral.

### Step 1: square it

$$
\begin{align*}
I^2 &= \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} x^2 \right) dx \cdot \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} y^2 \right) dy \\[1ex]
&= \iint_{\mathbb{R}^2} \exp \left( -\frac{1}{2}(x^2 + y^2) \right) dx \, dy .
\end{align*}
$$

The integrand is positive, so Tonelli's theorem allows us to combine the two integrals into a double integral.

### Step 2: switch to polar coordinates

Let

$$
\left\{
\begin{aligned}
x &= r \cos \theta \\
y &= r \sin \theta
\end{aligned}
\right.
\qquad r \in [0, \infty), \ \theta \in [0, 2\pi) .
$$

The **Jacobian matrix** of this map is

$$
J(r, \theta) = \frac{\partial (x, y)}{\partial (r, \theta)} =
\begin{bmatrix}
\dfrac{\partial x}{\partial r} & \dfrac{\partial x}{\partial \theta} \\[1.5ex]
\dfrac{\partial y}{\partial r} & \dfrac{\partial y}{\partial \theta}
\end{bmatrix}
=
\begin{bmatrix}
\cos \theta & - r \sin \theta \\
\sin \theta & r \cos \theta
\end{bmatrix} ,
$$

so the area element transforms as

$$
\begin{align*}
dx \, dy &= \left\lvert \det J(r, \theta) \right\rvert \, dr \, d\theta \\[1ex]
&= r \left( \cos^2 \theta + \sin^2 \theta \right) dr \, d\theta \\[1ex]
&= r \, dr \, d\theta .
\end{align*}
$$

### Step 3: integrate

$$
\begin{align*}
I^2 &= \int_0^{2 \pi} \int_0^{\infty} \exp \left( -\frac{1}{2} r^2 \right) r \, dr \, d\theta \\[1ex]
&= \int_0^{2 \pi} \left[ -\exp \left( -\frac{1}{2} r^2 \right) \right]_0^{\infty} d\theta \\[1ex]
&= \int_0^{2 \pi} 1 \, d\theta = 2 \pi .
\end{align*}
$$

Since $$I > 0$$,

$$
\int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} x^2 \right) dx = \sqrt{2 \pi} .
$$

**Shifting and scaling.** Substituting $$x \mapsto (x - b)/\sqrt{a}$$ gives, for any $$a > 0$$ and $$b \in \mathbb{R}$$,

$$
\int_{-\infty}^{\infty} \exp \left( -\frac{(x - b)^2}{2a} \right) dx = \sqrt{2 \pi a} ,
$$

or, in the form of a Gaussian density,

$$
\int_{-\infty}^{\infty} \frac{1}{\sqrt{2 \pi a}} \exp \left( -\frac{(x - b)^2}{2 a} \right) dx = 1 .
$$

---

## II. From one dimension to many

Now we generalize the univariate Gaussian integral to $$n$$ dimensions.

**Notation.**

1. $$\boldsymbol{x} = (x_1, \dots, x_n)^\top \in \mathbb{R}^n$$ is a column vector.
2. $$d\boldsymbol{x}$$ denotes the volume element $$dx_1 \cdots dx_n$$.
3. For $$f: \mathbb{R}^n \to \mathbb{R}$$, $$\displaystyle \int_{\mathbb{R}^n} f(\boldsymbol{x}) \, d \boldsymbol{x} = \idotsint_{\mathbb{R}^n} f(x_1, \dots, x_n) \, dx_1 \cdots dx_n$$.

**Statement.** Let $$A \in \mathbb{R}^{n \times n}$$ be symmetric positive definite, and let $$\boldsymbol{b} \in \mathbb{R}^n$$. Then

$$
\begin{equation}
\int_{\mathbb{R}^n} \exp\left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^\top A^{-1} (\boldsymbol{x} - \boldsymbol{b}) \right) d\boldsymbol{x} = \sqrt{ (2 \pi)^n \det A } .
\label{eq:multivariate}
\end{equation}
$$

For $$n = 1$$ and $$A = a$$, this is exactly the shifted and scaled formula above.

### Step 1: diagonalize

Since $$A$$ is symmetric positive definite, so is $$A^{-1}$$. By the [spectral theorem](https://math.mit.edu/~dav/spectral.pdf),

$$
A^{-1} = Q^\top \Lambda Q ,
$$

where $$\Lambda = \mathrm{diag}(\lambda_1, \dots, \lambda_n)$$ has **positive** diagonal entries and $$Q$$ is **orthogonal** ($$Q^\top Q = Q Q^\top = I$$).

Change variables to

$$
\boldsymbol{y} = Q (\boldsymbol{x} - \boldsymbol{b}) , \qquad \text{i.e.} \quad y_i = \sum_{j = 1}^{n} Q_{ij} (x_j - b_j) .
$$

Then $$\partial y_i / \partial x_k = Q_{ik}$$, so the Jacobian matrix is $$\partial \boldsymbol{y} / \partial \boldsymbol{x} = Q$$. An orthogonal matrix satisfies $$\det(Q)^2 = \det(Q^\top Q) = 1$$, so $$\det Q = \pm 1$$. (It can be $$-1$$, for a reflection. That is why the absolute value matters.) Hence

$$
d \boldsymbol{y} = \left\lvert \det Q \right\rvert d \boldsymbol{x} = d \boldsymbol{x} .
$$

Substituting,

$$
\begin{align*}
&\int_{\mathbb{R}^n} \exp\left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^\top A^{-1} (\boldsymbol{x} - \boldsymbol{b}) \right) d\boldsymbol{x} \\[1ex]
={} &\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^\top Q^\top \Lambda Q (\boldsymbol{x} - \boldsymbol{b}) \right) d \boldsymbol{x} \\[1ex]
={} &\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \big(Q (\boldsymbol{x} - \boldsymbol{b}) \big)^\top \Lambda \big(Q (\boldsymbol{x} - \boldsymbol{b}) \big) \right) d \boldsymbol{x} \\[1ex]
={} &\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \boldsymbol{y}^\top \Lambda \boldsymbol{y} \right) d \boldsymbol{y} .
\end{align*}
$$

### Step 2: separate the variables

Because $$\Lambda$$ is diagonal,

$$
\boldsymbol{y}^\top \Lambda \boldsymbol{y}
=
\begin{bmatrix} y_1 & \cdots & y_n \end{bmatrix}
\begin{bmatrix}
\lambda_1 & & \\
& \ddots & \\
& & \lambda_n
\end{bmatrix}
\begin{bmatrix} y_1 \\ \vdots \\ y_n \end{bmatrix}
= \sum_{i=1}^{n} \lambda_i y_i^2 ,
$$

so the exponential factors into a product, and so does the integral:

$$
\begin{align*}
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \boldsymbol{y}^\top \Lambda \boldsymbol{y} \right) d \boldsymbol{y}
&= \idotsint_{\mathbb{R}^n} \prod_{i=1}^{n} \exp \left( -\frac{1}{2} \lambda_i y_i^2 \right) dy_1 \cdots dy_n \\[1ex]
&= \prod_{i=1}^{n} \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} \lambda_i y_i^2 \right) dy_i .
\end{align*}
$$

### Step 3: use the one-dimensional result

Each factor is a one-dimensional Gaussian integral with $$a = 1/\lambda_i$$:

$$
\prod_{i=1}^{n} \int_{-\infty}^{\infty} \exp \left( -\frac{y_i^2}{2 \lambda_i^{-1}} \right) dy_i
= \prod_{i=1}^{n} \sqrt{\frac{2 \pi}{\lambda_i}}
= \frac{(2 \pi)^{n/2}}{\sqrt{\det \Lambda}} .
$$

Finally, from $$A^{-1} = Q^\top \Lambda Q$$,

$$
\frac{1}{\det A} = \det (A^{-1}) = \det(Q^\top) \det(\Lambda) \det(Q) = \det(Q)^2 \det \Lambda = \det \Lambda .
$$

Putting everything together,

$$
\int_{\mathbb{R}^n} \exp\left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^\top A^{-1} (\boldsymbol{x} - \boldsymbol{b}) \right) d\boldsymbol{x}
= \frac{(2 \pi)^{n/2}}{\sqrt{\det \Lambda}}
= \sqrt{ (2 \pi)^n \det A } ,
$$

which proves $$\eqref{eq:multivariate}$$. $$\blacksquare$$

---

## III. Probability and linear algebra

### 1. The univariate Gaussian distribution

If $$X \sim \mathcal{N}(\mu, \sigma^2)$$, its density integrates to one:

$$
\int_{-\infty}^{\infty} f_X(x) \, dx = \int_{-\infty}^{\infty} \frac{1}{\sqrt{2 \pi \sigma^2}} \exp \left( -\frac{(x - \mu)^2}{2 \sigma^2} \right) dx = 1 .
$$

This is just the shifted and scaled formula from Part I: the mean $$\mu$$ plays the role of the shift $$b$$, and the variance $$\sigma^2$$ plays the role of the scale $$a$$.

### 2. The multivariate Gaussian distribution

We write a **random vector** in bold capitals, $$\boldsymbol{X} = (X_1, \dots, X_n)^\top$$. Each component $$X_i$$ is a random variable. A specific value of $$\boldsymbol{X}$$ is written in bold lowercase, $$\boldsymbol{x}$$.

If $$\boldsymbol{X} \sim \mathcal{N}(\boldsymbol{\mu}, \Sigma)$$ with a positive definite covariance matrix $$\Sigma$$, then by $$\eqref{eq:multivariate}$$ with $$A = \Sigma$$ and $$\boldsymbol{b} = \boldsymbol{\mu}$$,

$$
\int_{\mathbb{R}^n} f_{\boldsymbol{X}}(\boldsymbol{x}) \, d \boldsymbol{x}
= \int_{\mathbb{R}^n} \frac{1}{\sqrt{(2\pi)^n \det \Sigma}} \exp \left( -\frac{1}{2} (\boldsymbol{x}-\boldsymbol{\mu})^\top \Sigma^{-1}(\boldsymbol{x}-\boldsymbol{\mu})\right) d \boldsymbol{x} = 1 .
$$

The interesting part is the change of variables that simplified the quadratic form in the exponent. It has a clear probabilistic meaning.

#### (1) Diagonalizing $$\Sigma^{-1}$$: the PCA view

Write

$$
\Sigma^{-1} = Q^\top \Lambda Q ,
$$

where the **rows** of the orthogonal matrix $$Q$$ are eigenvectors of $$\Sigma^{-1}$$, and $$\Lambda$$ holds the corresponding eigenvalues. The eigenvectors of $$\Sigma^{-1}$$ are the same as those of $$\Sigma$$, but each eigenvalue is inverted: $$\Sigma = Q^\top \Lambda^{-1} Q$$.

This is exactly the core idea of [principal component analysis](https://www.cs.cmu.edu/~elaw/papers/pca.pdf) (PCA). We find the principal axes of the distribution and rotate the coordinate system to align with them. The variance along the $$i$$-th axis is $$1/\lambda_i$$, so the direction of **largest** variance belongs to the **smallest** eigenvalue of $$\Sigma^{-1}$$.

#### (2) The change of variables

Apply

$$
\boldsymbol{y} = Q (\boldsymbol{x} - \boldsymbol{\mu}) , \qquad \text{equivalently} \qquad \boldsymbol{Y} = Q (\boldsymbol{X} - \boldsymbol{\mu}) .
$$

This centers and rotates the coordinate system, and the quadratic form becomes

$$
(\boldsymbol{x} - \boldsymbol{\mu})^\top \Sigma^{-1} (\boldsymbol{x} - \boldsymbol{\mu}) = \boldsymbol{y}^\top \Lambda \boldsymbol{y} .
$$

The covariance of the new random vector is

$$
\mathrm{Cov}(\boldsymbol{Y}) = \mathbb{E}\left[\boldsymbol{Y} \boldsymbol{Y}^\top\right] = Q \, \Sigma \, Q^\top = Q \left( Q^\top \Lambda^{-1} Q \right) Q^\top = \Lambda^{-1} ,
$$

which is **diagonal**. So the components $$Y_1, \dots, Y_n$$ are **uncorrelated**, with $$\mathrm{Var}(Y_i) = 1/\lambda_i$$. Going from $$\boldsymbol{X}$$ to $$\boldsymbol{Y}$$ decorrelates the coordinates.

#### (3) Uncorrelated vs. independent

In general, uncorrelated random variables need not be independent. But **for a jointly Gaussian random vector, uncorrelated components are independent.** (Marginally Gaussian is not enough: the vector must be jointly Gaussian.) Here $$\boldsymbol{Y}$$ is an affine function of a Gaussian vector, so it is jointly Gaussian.

You can see this directly from the density, which factors into a product of one-dimensional Gaussians:

$$
f_{\boldsymbol{Y}}(\boldsymbol{y}) = \prod_{i=1}^n \frac{1}{\sqrt{2\pi\lambda_i^{-1}}} \exp\left( -\frac{y_i^2}{2\lambda_i^{-1}} \right) = \prod_{i=1}^n \mathcal{N}\!\left(y_i;\, 0,\, \lambda_i^{-1}\right) .
$$

This factorization is exactly what made the integral in Part II easy to compute.

---

> Thanks to ChatGPT, which helped me organize my words.
