---
layout: post
title: The Continuity Equation
date: 2025-06-17 00:00:00+0800
description: Deriving the continuity equation step by step, from conservation laws to the divergence theorem.
tags: [divergence, conservation-laws, pde]
categories: physics
toc:
  sidebar: left
---

> This post was revised with the help of ChatGPT.

This post walks through the **continuity equation**, from physical intuition to the mathematical statement. We derive it step by step and explain every quantity involved.

---

## 1. Motivation: conservation in physical systems

Many physical quantities are conserved, for example:

- **mass** in a closed system;
- **charge** in electromagnetism;
- **energy** in an isolated system;
- the **number of particles** in a fluid.

Although these quantities are conserved **globally**, they **vary locally** in space and time. To describe their local behavior, we use _density functions_. A density tells us how much of the conserved quantity there is per unit volume at each point and time:

- mass density $$\rho(\boldsymbol{x}, t)$$;
- charge density $$\rho_q(\boldsymbol{x}, t)$$;
- energy density $$\epsilon(\boldsymbol{x}, t)$$;
- particle number density $$n(\boldsymbol{x}, t)$$.

Each of these is a function $$\mathbb{R}^n \times \mathbb{R}_{\ge 0} \to \mathbb{R}$$.

To model how a density evolves, imagine the quantity being carried by a flow. A tiny **fluid parcel** at position $$\boldsymbol{x}$$ and time $$t$$ moves with velocity $$\boldsymbol{v}(\boldsymbol{x}, t)$$ and carries the local amount of the quantity with it.

Our goal is a **local law** describing how the density changes over space and time. This law is the **continuity equation**.

---

## 2. Basic definitions

Let:

- $$\rho(\boldsymbol{x}, t): \mathbb{R}^n \times \mathbb{R}_{\ge 0} \to \mathbb{R}$$ be the scalar **density** of a conserved quantity;
- $$\boldsymbol{J}(\boldsymbol{x}, t): \mathbb{R}^n \times \mathbb{R}_{\ge 0} \to \mathbb{R}^n$$ be the **flux**. Its component along a unit vector $$\boldsymbol{n}$$ is the amount of the quantity crossing a unit area perpendicular to $$\boldsymbol{n}$$ per unit time.

When the quantity is transported by a velocity field $$\boldsymbol{v}(\boldsymbol{x}, t)$$, the flux is

$$
\boldsymbol{J}(\boldsymbol{x}, t) = \rho(\boldsymbol{x}, t) \, \boldsymbol{v}(\boldsymbol{x}, t) .
$$

In words, flux is density times velocity: how much passes through depends on how much is there and how fast it moves.

Now fix a region $$V \subset \mathbb{R}^n$$ with a smooth boundary $$\partial V$$.

- The **total amount inside $$V$$** at time $$t$$ is

  $$
  Q_V(t) = \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} .
  $$

- Its **rate of change** is

  $$
  \frac{d}{dt} Q_V(t) = \frac{d}{dt} \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} .
  $$

  Since the quantity is conserved (there are no sources or sinks), this change can only come from **flux across the boundary** $$\partial V$$.

---

## 3. Flux across the boundary

Each point $$\boldsymbol{x} \in \partial V$$ has an **outward unit normal** $$\boldsymbol{n}(\boldsymbol{x})$$. Let $$dS$$ be the surface area element, and let $$d\boldsymbol{S} = \boldsymbol{n} \, dS$$ be the oriented surface element, pointing outward.

The **net outflow** through $$\partial V$$ per unit time is

$$
\oint_{\partial V} \boldsymbol{J}(\boldsymbol{x}, t) \cdot d\boldsymbol{S} .
$$

The dot product keeps only the component of the flux normal to the surface; flow tangent to the surface does not cross it. The integral is positive when more of the quantity leaves than enters.

Conservation says that the amount inside decreases exactly at the rate it flows out:

$$
\frac{d}{dt} \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} = - \oint_{\partial V} \boldsymbol{J}(\boldsymbol{x}, t) \cdot d\boldsymbol{S} .
$$

This is the **integral form** of the conservation law.

---

## 4. Gauss's divergence theorem

To turn the boundary integral into a volume integral, we use the **divergence theorem**. It holds for a continuously differentiable field $$\boldsymbol{J}$$:

$$
\oint_{\partial V} \boldsymbol{J}(\boldsymbol{x}, t) \cdot d\boldsymbol{S} = \int_V \nabla \cdot \boldsymbol{J}(\boldsymbol{x}, t) \, d\boldsymbol{x} .
$$

The theorem says that the total outward flux through the boundary equals the total **divergence** inside:

- the left-hand side adds up what flows **out of** each patch of the surface;
- the right-hand side adds up the local "spreading out" of the flow at each point inside $$V$$.

Substituting into the conservation law gives

$$
\frac{d}{dt} \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} = - \int_V \nabla \cdot \boldsymbol{J}(\boldsymbol{x}, t) \, d\boldsymbol{x} .
$$

---

## 5. From integral form to differential form

If $$\rho$$ is smooth enough (see [Section 8](#8-why-can-we-swap-the-derivative-and-the-integral)), we may move the time derivative inside the integral:

$$
\frac{d}{dt} \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} = \int_V \frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} \, d\boldsymbol{x} .
$$

Thus

$$
\int_V \frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} \, d\boldsymbol{x} = - \int_V \nabla \cdot \boldsymbol{J}(\boldsymbol{x}, t) \, d\boldsymbol{x} ,
$$

and moving everything to one side,

$$
\int_V \left( \frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} + \nabla \cdot \boldsymbol{J}(\boldsymbol{x}, t) \right) d\boldsymbol{x} = 0 .
$$

This holds for **every** region $$V$$. If the integrand $$g = \partial_t \rho + \nabla \cdot \boldsymbol{J}$$ is continuous, it must vanish **pointwise**. To see why, suppose $$g(\boldsymbol{x}_0, t) > 0$$ at some point. By continuity, $$g > 0$$ on a small ball $$B$$ around $$\boldsymbol{x}_0$$, and then $$\int_B g \, d\boldsymbol{x} > 0$$, a contradiction. The same argument works if $$g(\boldsymbol{x}_0, t) < 0$$. Therefore

$$
\frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} + \nabla \cdot \boldsymbol{J}(\boldsymbol{x}, t) = 0 .
$$

---

## 6. The continuity equation

Using $$\boldsymbol{J} = \rho \, \boldsymbol{v}$$, we obtain the **continuity equation**:

$$
\begin{equation}
\frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} + \nabla \cdot \big(\rho(\boldsymbol{x}, t) \, \boldsymbol{v}(\boldsymbol{x}, t)\big) = 0 .
\label{eq:continuity}
\end{equation}
$$

It expresses the **local conservation** of the quantity carried by the flow.

**Expanded form.** By the product rule, $$\nabla \cdot (\rho \boldsymbol{v}) = \boldsymbol{v} \cdot \nabla \rho + \rho \, \nabla \cdot \boldsymbol{v}$$, so

$$
\underbrace{\frac{\partial \rho}{\partial t} + \boldsymbol{v} \cdot \nabla \rho}_{\displaystyle \frac{D\rho}{Dt}} = - \rho \, \nabla \cdot \boldsymbol{v} .
$$

The left-hand side is the **material derivative** $$D\rho / Dt$$, the rate of change of density seen by an observer moving with a parcel. So the density following a parcel changes only when the flow compresses ($$\nabla \cdot \boldsymbol{v} < 0$$) or expands ($$\nabla \cdot \boldsymbol{v} > 0$$). For an **incompressible** flow ($$\nabla \cdot \boldsymbol{v} = 0$$), the density along each parcel stays constant.

---

## 7. Divergence: geometric meaning

The divergence of a vector field is

$$
\nabla \cdot \boldsymbol{J}(\boldsymbol{x}, t) = \sum_{i=1}^n \frac{\partial J_i(\boldsymbol{x}, t)}{\partial x_i} .
$$

By the continuity equation, $$\partial_t \rho = -\nabla \cdot \boldsymbol{J}$$. So:

- if $$\nabla \cdot \boldsymbol{J} > 0$$ at a point, more flows **out** than in, and $$\rho$$ **decreases** there;
- if $$\nabla \cdot \boldsymbol{J} < 0$$, more flows **in** than out, and $$\rho$$ **increases**;
- if $$\nabla \cdot \boldsymbol{J} = 0$$, inflow and outflow balance, and $$\rho$$ does not change there.

Geometrically, divergence is a **local** measure of how much a vector field "spreads out" at a point. This follows from the divergence theorem: shrink $$V$$ to a small ball $$B_r(\boldsymbol{x})$$ around a point, and

$$
\nabla \cdot \boldsymbol{J}(\boldsymbol{x}) = \lim_{r \to 0} \frac{1}{\lvert B_r \rvert} \oint_{\partial B_r} \boldsymbol{J} \cdot d\boldsymbol{S} ,
$$

i.e. divergence is the outward flux per unit volume.

---

## 8. Why can we swap the derivative and the integral?

We used

$$
\frac{d}{dt} \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} = \int_V \frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} \, d\boldsymbol{x} .
$$

By definition of the derivative,

$$
\begin{align*}
\frac{d}{dt} \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x}
&= \lim_{\Delta t \to 0} \frac{1}{\Delta t} \left( \int_V \rho(\boldsymbol{x}, t + \Delta t) \, d\boldsymbol{x} - \int_V \rho(\boldsymbol{x}, t) \, d\boldsymbol{x} \right) \\[1ex]
&= \lim_{\Delta t \to 0} \int_V \frac{\rho(\boldsymbol{x}, t + \Delta t) - \rho(\boldsymbol{x}, t)}{\Delta t} \, d\boldsymbol{x} \\[1ex]
&\overset{(\star)}{=} \int_V \lim_{\Delta t \to 0} \frac{\rho(\boldsymbol{x}, t + \Delta t) - \rho(\boldsymbol{x}, t)}{\Delta t} \, d\boldsymbol{x}
= \int_V \frac{\partial \rho(\boldsymbol{x}, t)}{\partial t} \, d\boldsymbol{x} .
\end{align*}
$$

The step $$(\star)$$, which swaps the limit and the integral, is the only one that needs justification. A sufficient condition is that $$V$$ is bounded and $$\partial_t \rho$$ is continuous on $$\overline{V} \times [t - \delta, t + \delta]$$. By the mean value theorem, the difference quotient equals $$\partial_t \rho(\boldsymbol{x}, t + \theta \Delta t)$$ for some $$\theta \in (0, 1)$$. This is uniformly bounded, so the dominated convergence theorem applies. (The region $$V$$ is fixed in time. For a region that moves with the flow, you would need the Reynolds transport theorem instead.)

---

## 9. Summary

We began with:

- a physical idea: a conserved quantity;
- a model: the quantity is carried by a flow with velocity $$\boldsymbol{v}$$;
- a density $$\rho(\boldsymbol{x}, t)$$ and a flux $$\boldsymbol{J} = \rho \boldsymbol{v}$$;
- a balance law: rate of change inside a region = $$-$$(net outflow through its boundary);
- the divergence theorem: surface integral $$\to$$ volume integral;
- swapping derivative and integral: $$\frac{d}{dt}\int_V = \int_V \partial_t$$;
- "zero integral over every region" $$\Rightarrow$$ "zero integrand."

We arrived at

$$
\frac{\partial \rho}{\partial t} + \nabla \cdot (\rho \, \boldsymbol{v}) = 0 .
$$

The continuity equation appears whenever we model a conserved quantity moving through space. It captures one simple idea:

> Any local change in the quantity must be explained by its flow into or out of that region.

It is fundamental across physics and mathematics: in fluid mechanics, electromagnetism (conservation of charge), quantum mechanics (conservation of probability), and, more recently, in the flow-matching and diffusion models of machine learning, where it describes how a probability density is transported by a learned velocity field.
