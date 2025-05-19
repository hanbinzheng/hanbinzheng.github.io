---
layout: post
title: The Gaussian Integral
date: 2025-05-19 +0800
categories: [Math, Probability]
tags: [Math, Probability, PCA, Gaussian, Integral]
---

> This post introduces the Gaussian integral, starting from basic integration and gradually building towards a probabilistic and linear algebraic perspective.

> The exposition proceeds from a purely mathematical derivation to a more intuitive understanding grounded in probability and linear algebra.

## I. The Fundamental Theorem

The most fundamental Gaussian Integral is as follows:

$$
\int_{-\infty}^{\infty} \exp \left(-\frac{1}{2}x^2 \right) dx = \sqrt{2\pi}
$$

Equivalently, in the form of the **standard Gaussian distribution**:

$$
\frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} x^2 \right) dx = 1
$$

Here is how to compute this integral. For convenience, denote this integral by $$\mathrm{I}$$.

### Step1

$$
\begin{align*}
\mathrm{I} &= \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2}x^2 \right) dx \\ \\ 
\mathrm{I}^2 &= \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} x^2 \right) dx \; \cdot \; \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} y^2 \right) dy \\ \\
&= \iint_{\mathbb{R}^2} \exp \left( -\frac{1}{2}(x^2 + y^2) \right) dx \; dy
\end{align*}
$$

---

### Step2

Transform from **Cartesian Coordinates** to **Polar Coordinates**, where 

$$
\left \{
\begin{align*}
x &= r \; \cos (\theta) \\
y &= r \; \sin (\theta)
\end{align*}
\right.
$$

And the **Jacobian matrix** for this transform is:

$$
\mathrm{J}(r, \theta) = \frac{\partial (x, y)}{\partial (r, \theta)} =\begin{bmatrix}
\frac{\partial x}{\partial r} & \frac{\partial x}{\partial \theta} \\
\frac{\partial y}{\partial r} & \frac{\partial y}{\partial \theta} 
\end{bmatrix} 
= \begin{bmatrix}
\cos (\theta) & - r \sin (\theta) \\
\sin (\theta) & r \cos (\theta)
\end{bmatrix}
$$

and the transform from $$dx \; dy$$  to $$dr \; d \theta$$  is:

$$
\begin{align*}
dx \; dy &= \det \left( \mathrm{J}(r, \theta) \right) dr \; d \theta \\ \\
&= r \left( \cos^2 (\theta) + \sin^2 (\theta) \right) \;dr \; d \theta\\ \\
&= r \; dr \; d \theta
\end{align*}
$$

---

### Step3

So after the transform, the equation for integral $$\mathrm{I}$$ is:

$$
\begin{align*}
\mathrm{I}^2 &= \iint_{\mathbb{R}^2}\exp \left( -\frac{1}{2} r^2 \right) \; r \; dr \; d \theta \\ \\
&= \int_0^{2 \pi} \left( \int_0^{\infty} \exp \left( -\frac{1}{2} r^2 \; \right) \; r \; dr \; \right) \; d \theta \\ \\
&= \int_0^{2 \pi} 1 \cdot d \theta \\ \\
&= 2 \pi
\end{align*}
$$

And thus:

$$
\int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} x^2 \right) \,dx = \sqrt{2 \pi}
$$

By the law of substitution, the following equation also holds: 

$$
\text{For any } a > 0 \text{ and } \forall b \in \mathbb{R}, \quad \int_{-\infty}^{\infty} \exp \left( -\frac{1}{2} \frac{1}{a}(x - b)^2\right) \; dx = \sqrt{2 \pi a}
$$

Or equivantly, written in the form of Gaussian distribution: 

$$
\int_{-\infty}^{\infty} \frac{1}{\sqrt{2 \pi a}} 
\exp \left( -\frac{(x - b)^2}{2 a} \right) \; dx = 1
$$

---

## II. From Univariate to Multivariate

We now generalize the **univariate Gaussian Integral** into **multivariate** cases.

Firstly, clarify some notation:

$$
\begin{align*}
&\text{(1)} \quad 
\boldsymbol{x} = \begin{bmatrix} x_1 \\ \vdots \\ x_n \end{bmatrix}, \boldsymbol{x} 
\in \mathbb{R}^n, \quad 
\text{where } x_i \in \mathbb{R}, \quad i = 1, \dots, n \\[1.5ex]

&\text{(2)} \quad 
d \boldsymbol{x} \; \text{ denotes the product measure } \; 
\prod_{i=1}^n dx_i \\[1.5ex]

&\text{(3)} \quad
\text{Let } f:  \mathbb{R}^n \to \mathbb{R}. 
\text{Then} \int_{\mathbb{R}^n} f(\boldsymbol{x}) \, d \boldsymbol{x} 
= \idotsint_{x_1, \dots , x_n \in \mathbb{R}} f(x_1, \dots, x_n) \,dx_1 \cdots dx_n
\end{align*}
$$

The statements are below:

$$
\begin{align*}
\text{Let } A &\in \mathbb{R}^{n \times n} \text{ be symmetric and positive definite, and let } \boldsymbol{b} \in \mathbb{R}^n, \\[2ex]

&\int_{\mathbb{R}^n} 
\exp\left( 
  -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^T A^{-1} (\boldsymbol{x} - \boldsymbol{b}) 
\right) 
\, d\boldsymbol{x} 
=  \sqrt{ \left(2 \pi \right) ^n \cdot \det (A)  }
\end{align*}
$$

Here are steps to calculate it.

---

### Step1

Since $$A$$ is **symmetric and positive definite** matrix, thus $$A^{-1}$$ is also  **symmetric and positive definite** matrix.

The [Spectral Theorem](https://math.mit.edu/~dav/spectral.pdf) guarantees that:

$$
A^{-1} = Q^T \Lambda Q,
$$

where $\Lambda$ is a **diagonal matrix** with positive entries, and $Q$ is an **orthogonal matrix**(i.e., $Q^T Q = QQ^T = I$).

Then transform the variable:

$$
\boldsymbol{y} = Q (\boldsymbol{x} - \boldsymbol{b}).
$$

Or, for the convenience of integration, 

$$
\boldsymbol{y} = f(\boldsymbol{x}) =
\begin{bmatrix}
f_1(x_1, \dots, x_n) \\
f_2(x_1, \dots, x_n) \\
\vdots \\
f_n(x_1, \dots, x_n)
\end{bmatrix}
\in \mathbb{R}^n,
$$

where the corresponding **Jacobian Matrix** is:

$$
\mathrm{J} = \frac{\partial \boldsymbol{y}}{\partial \boldsymbol{x}} =
\begin{bmatrix}
\frac{\partial f_1}{\partial x_1} & \cdots & \frac{\partial f_1}{\partial x_n} \\
\vdots & \ddots & \vdots \\
\frac{\partial f_n}{\partial x_1} & \cdots & \frac{\partial f_n}{\partial x_n}
\end{bmatrix}
\in \mathbb{R}^{n \times n}.
$$

Since $$y_i = \sum_{i = 0}^{n} Q_{ij} (x_i - b_i)$$ and $$\frac{\partial f_i}{\partial x_k} = \frac{\partial y_i}{\partial x_k} = Q_{ik}$$ , 

$$
\mathrm{J}

= \begin{bmatrix}
\frac{\partial f_1}{\partial x_1} & \cdots & \frac{\partial f_1}{\partial x_n} \\
\vdots & \ddots & \vdots \\
\frac{\partial f_n}{\partial x_1} & \cdots & \frac{\partial f_n}{\partial x_n}
\end{bmatrix}

= Q, \quad \text{and } \det{(\mathrm{J})} = \det{(\mathrm{Q})} = 1
$$

So that

$$
d \boldsymbol{y} = \frac{\partial(y_1,\dots, y_n)}{\partial(x_1, \dots, x_n)} d \boldsymbol{x}= \det{(\mathrm{J})} \, d \boldsymbol{x} = d \boldsymbol{x}.
$$

Therefore, 

$$
\begin{align*}
\int_{\mathbb{R}^n} \exp\left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^T A^{-1} (\boldsymbol{x} - \boldsymbol{b}) \right) \, d\boldsymbol{x} 
&=
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^T Q^T \Lambda Q (\boldsymbol{x} - \boldsymbol{b}) \right) \, d \boldsymbol{x} \\[2ex]
&= 
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \left(Q (\boldsymbol{x} - \boldsymbol{b}) \right)^T \Lambda \left(Q (\boldsymbol{x} - \boldsymbol{b}) \right) \right) \, d \boldsymbol{x} \\[2ex]
&=
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \boldsymbol{y}^T \Lambda \boldsymbol{y} \right) \, d \boldsymbol{y}.
\end{align*}
$$

---

### Step2

We focus on $$\boldsymbol{y}^T \Lambda \boldsymbol{y}$$ :

$$
\boldsymbol{y}^T \Lambda \boldsymbol{y} 
=
\begin{bmatrix} y_1 & y_2 & \dots & y_n\end{bmatrix} 

\begin{bmatrix} 
\lambda_1 & \cdots & 0 \\
\vdots & \ddots & \vdots \\
0 & \cdots & \lambda_n 
\end{bmatrix}

\begin{bmatrix} y_1  \\ \vdots \\ y_n\end{bmatrix}

= \sum_{i=1}^{n}\lambda_i y_i^2
$$

So ,

$$
\begin{align*}
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \boldsymbol{y}^T \Lambda \boldsymbol{y} \right) \, d \boldsymbol{y} 
&= 
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \sum_{i=1}^{n}\lambda_i y_i^2 \right) \, d \boldsymbol{y} \\[2ex]
&=
\idotsint_{y_1, \dots , y_n \in \mathbb{R}}  \exp \left( -\frac{1}{2} \sum_{i=1}^{n}\lambda_i y_i^2 \right) \,dy_1 \cdots dy_n \\[2ex]
&=
\idotsint_{y_1, \dots , y_n \in \mathbb{R}} \prod_{i=1}^{n} \exp \left( -\frac{1}{2} \lambda_i y_i^2 \right) \,dy_1 \cdots dy_n \\[2ex]
&=
\prod_{i=1}^{n} \int_{y_i \in \mathbb{R}}\exp \left( -\frac{1}{2} \lambda_i y_i^2 \right) \, d y_i
\end{align*}
$$

---

### Step3

Using the result from univariate case, we obtain that:

$$
\prod_{i=1}^{n} \int_{y_i \in \mathbb{R}}\exp \left( -\frac{1}{2} \lambda_i y_i^2 \right) \, d y_i 
= 
\prod_{i=1}^{n} \sqrt{\frac{2 \pi}{\lambda_i}}
=
\frac{\left( \sqrt{2 \pi} \right)^n}{\sqrt{\det (\Lambda)}}
$$

Since

$$
A^{-1} = Q^T \Lambda Q,
$$

then

$$
\begin{align*}
\quad \det{(A^{-1})} 
&= \det{(Q^T)} \det{(\Lambda)} \det{(Q)} \\[1.5ex]
&= \det{(\Lambda)} \\[1.5ex]
&= \frac{1}{\det{(A)}}
\end{align*}
$$

So, 

$$
\begin{align*}
\int_{\mathbb{R}^n} \exp\left( -\frac{1}{2} (\boldsymbol{x} - \boldsymbol{b})^T A (\boldsymbol{x} - \boldsymbol{b}) \right) \, d\boldsymbol{x} 
&=
\int_{\mathbb{R}^n} \exp \left( -\frac{1}{2} \boldsymbol{y}^T \Lambda \boldsymbol{y} \right) \, d \boldsymbol{y} \\[2ex]
&=
\prod_{i=1}^{n} \int_{y_i \in \mathbb{R}}\exp \left( -\frac{1}{2} \lambda_i y_i^2 \right) \, d y_i  \\[2ex]
&=
\frac{\left( \sqrt{2 \pi} \right)^n}{\sqrt{\det (\Lambda)}} \\[2ex]
&= \sqrt{ \left( 2 \pi \right) ^n \cdot \det (A) }

\end{align*}
$$

---

## III Probability & Linear Algebra Perspectives

### 1. Univariate Gaussian Distribution

$$
\begin{equation*}
\begin{aligned}
\text{Let a Gaussian random variable } X &\sim \mathcal{N} (\mu, \, \sigma^2), \text{then:}\\
\int_{-\infty}^{\infty} f_X(x) \; dx &= \int_{-\infty}^{\infty} \frac{1}{\sqrt{2 \pi \sigma^2}} 
\exp \left( -\frac{(x - \mu)^2}{2 \sigma^2} \right) \; dx = 1
\end{aligned}
\end{equation*}
$$

This normalization condition is straightforward: the mean $$\mu$$ and variance $$\sigma^2$$ simply play the roles of shift and scaling parameters (analogous to $$b$$ and $$a$$ in standard variable transformations).

---

### 2. Multivariate Gaussian Distribution

Firstly, clarify some notation:

$$
\boldsymbol{X} = \begin{bmatrix} X_1 \\ \vdots \\ X_n \end{bmatrix}, \boldsymbol{X} 
\in \mathbb{R}^n, \quad 
\text{where } X_i \in \mathbb{R}, \quad i = 1, \dots, n
$$

The **bold** and captial $$\boldsymbol{X}$$ are **random vector** whose elements (i.e. **Captial** $$X_i \quad i = 1, \dots, n$$ )are **random variables**.

$$
\begin{equation*}
\begin{aligned}
\text{Let a Gaussian random vector } \boldsymbol{X} &\sim \mathcal{N} (\boldsymbol{\mu}, \, \Sigma), \text{then:} \\
\int_{\mathbb{R}^n} f_{\boldsymbol{X}}(\boldsymbol{x}) \; d \boldsymbol{x} &= \int_{\mathbb{R}} \frac{1}{\sqrt{\left(2\pi \right)^n \cdot \det(\Sigma)}} 
\exp \left( -\frac{1}{2} (\boldsymbol{x}-\boldsymbol{\mu})^T \Sigma^{-1}(\boldsymbol{x}-\boldsymbol{\mu})\right) \; d \boldsymbol{x} = 1
\end{aligned}
\end{equation*}
$$

We focus on the variable transformation that simplifies the quadratic form in the exponent.

---

#### (1) **Diagonalizing $$\Sigma^{-1}$$: PCA Perspective**

$$\Sigma^{-1} = Q^T \Lambda Q,$$

where $$Q$$ is an orthogonal matrix whose rows are the eigenvectors of $$\Sigma^{-1}$$, and $$\Lambda$$ is a diagonal matrix of corresponding eigenvalues. 

This procedure is exactly the core idea of [Principal Component Analysis](https://www.cs.cmu.edu/~elaw/papers/pca.pdf) (i.e. **PCA**): identifying the principal axes (directions of maximal variance) of the distribution and aligning the coordinate system accordingly.

And, the principal axed are **uncorrelated**.

---

#### (2) **Variable Transform**

We apply the transform of variable:

$$
\boldsymbol{y} = Q (\boldsymbol{x} - \boldsymbol{\mu}),
$$

or equivalently, 

$$
\boldsymbol{Y} = Q (\boldsymbol{X} - \boldsymbol{\mu}).
$$

which rotates and centers the coordinate system. Under this transformation, the quadratic form becomes:

$$
(\boldsymbol{x} - \boldsymbol{\mu})^T \Sigma^{-1} (\boldsymbol{x} - \boldsymbol{\mu}) = \boldsymbol{y}^T \Lambda \boldsymbol{y},
$$

From $$\boldsymbol{x}$$ to $$\boldsymbol{y}$$, we decouple correlated  $$\boldsymbol{x}$$ into uncorrelated  $$\boldsymbol{y}$$ ($$\Lambda$$ is the inverse of $$\mathrm{cov}(\boldsymbol{y}^T \boldsymbol{y})$$, and is a diogonal matrix).

---

#### (3) **Uncorelation and Independence**

For general distributions, uncorrelated variables are not necessarily independent.

However, **in the case of multivariate gaussian, uncorrelatedness does imply independence!**

This allows the joint distribution to be factored into a porduct of 1-D Gaussian densities:

$$
f_{\boldsymbol{Y}}(\boldsymbol{y}) = \prod_{i=1}^n \mathcal{N}(y_i; 0, \lambda_i^{-1}),
$$

greatly simplifying the integral.

---

> Thanks to Chat GPT. My Chinglish is childish and she helps to organise my words.
