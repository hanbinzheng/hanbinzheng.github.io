---
layout: post
title: "The Continuity Equation"
date: 2025-06-17T00:00:00+08:00
categories: [Physics]
tags: [Physics, Math, Divergence]
---

> This post is revised by Chat GPT.

This post presents a detailed walkthrough of the **continuity equation** from physical intuition to mathematical formalism. We aim to derive the equation step by step and explain all quantities involved.



------



## **1. Motivation: Conservation in Physical Systems**

Many physical quantities are conserved in nature. For instance:

- **Mass** in a closed system

- **Charge** in electromagnetic systems

- **Energy** in isolated systems

- **Number of particles** in fluid dynamics

  

Although these quantities are conserved **globally**, they **vary locally** in both space and time. To describe their local behavior, we define *density functions* that encode how much of a given conserved quantity exists per unit volume at any point and time:

- Mass density: $\rho(x, t)$
- Charge density: $\rho_q(x, t)$
- Energy density: $\epsilon(x, t)$
- Particle number density: $n(x, t)$

These are all functions $\mathbb{R}^n \times \mathbb{R}^+ \to \mathbb{R}$.



To model how these densities evolve, we introduce the idea of an abstract **fluid parcel** at position $x$ and time $t$. This fluid parcel carries a certain amount of the conserved quantity. The idea is purely conceptual, like a massless particle that moves with the flow, carrying the density value $\rho(x, t)$. Each parcel has a velocity $\mathbf{v}(x, t)$.



Our goal is to derive a **mathematical law** that describes how the distribution of this quantity evolves over space and time. This law is known as the **continuity equation**.



------



## **2. Fundamental Definitions**

Let’s define:

- $\rho(x, t): \mathbb{R}^n \times \mathbb{R}^+ \to \mathbb{R}$ — scalar **density function** of a conserved quantity
- $\mathbf{J}(x, t): \mathbb{R}^n \times \mathbb{R}^+ \to \mathbb{R}^n$ — **flux vector field**, giving how much quantity passes through a unit area per unit time

For a conserved quantity being transported by a velocity field $\mathbf{v}(x, t)$, the **flux** is given by:

$$
\mathbf{J}(x, t) := \rho(x, t) \cdot \mathbf{v}(x, t)
$$

That is, flux equals density multiplied by velocity. This states that the amount of quantity flowing through a point per unit area per unit time depends on how much is present and how fast it moves.



Now consider a fixed spatial region $V \subset \mathbb{R}^n$ with boundary $\partial V$.

- The **total quantity inside V at time t** is:

  
  $$
  Q_V(t) = \int_V \rho(x, t) \, dx
  $$
  

- Its **time derivative** represents how the total amount is changing:

  
  $$
  \frac{d}{dt} Q_V(t) = \frac{d}{dt} \int_V \rho(x, t) \, dx
  $$
  

  This change must result from **flux across the boundary** $$\partial V$$.

  

------



## **3. Flux Across the Boundary**

Each point $x \in \partial V$ has an **outward unit normal vector** $\mathbf{n}_x$. Define the **infinitesimal surface element** at $x$ to be $dS_x$. And, define the infinitesimal oriented surface vector element as $d\mathbf{S}_x = \mathbf{n}_x \, dS_x$, pointing outward.



Then the **net outflow** of quantity through $\partial V$ is:


$$
\oint_{\partial V} \mathbf{J}(x, t) \cdot d\mathbf{S}_x
$$


This measures how much of the quantity is **leaving** the region per unit time. If flux enters the region, this value becomes negative.



By conservation of the quantity:


$$
\frac{d}{dt} \int_V \rho(x, t) \, dx = - \oint_{\partial V} \mathbf{J}(x, t) \, d\mathbf{S}_x
$$


---



## **4. Gauss’s Divergence Theorem**

To transform the boundary integral into a volume integral, we apply the **divergence theorem**:


$$
\oint_{\partial V} \mathbf{J}(x, t) \, d\mathbf{S}_x = \int_V \nabla \cdot \mathbf{J}(x, t) \, dx
$$


The theorem relates the total outward flux through the boundary to the **divergence** of $\mathbf{J}$ inside the volume. Geometrically:

- The left-hand side sums the quantity flowing **out of** every surface patch
- The right-hand side sums the **local expansion or compression** of flow inside $V$



Substitute this into our equation:


$$
\frac{d}{dt} \int_V \rho(x, t) \, dx = - \int_V \nabla \cdot \mathbf{J}(x, t) \, dx
$$


This equation describes the **balance of flow and density**.



------



## **5. Commuting Derivative and Integral**

Suppose $\rho(x, t)$ is smooth enough (e.g., continuously differentiable in $t$). Then by standard analysis:


$$
\frac{d}{dt} \int_V \rho(x, t) \, dx = \int_V \frac{\partial \rho(x, t)}{\partial t} \, dx
$$


Thus:


$$
\int_V \frac{\partial \rho(x, t)}{\partial t} \, dx = - \int_V \nabla \cdot \mathbf{J}(x, t) \, dx
$$


Bring all terms to one side:


$$
\int_V \left( \frac{\partial \rho(x, t)}{\partial t} + \nabla \cdot \mathbf{J}(x, t) \right) dx = 0
$$


Since this holds for any volume $V$, the integrand must be zero **pointwise**:


$$
\frac{\partial \rho(x, t)}{\partial t} + \nabla \cdot \mathbf{J}(x, t) = 0
$$


---



## **6. The Continuity Equation**

Using $\mathbf{J}(x, t) = \rho(x, t) \cdot \mathbf{v}(x, t)$, we obtain:


$$
\frac{\partial \rho(x, t)}{\partial t} + \nabla \cdot (\rho(x, t) \cdot \mathbf{v}(x, t)) = 0
$$


This is the **continuity equation**, which expresses **local conservation** of the quantity carried by the flow.



------



## **7. Divergence: Geometric Interpretation**

The divergence of a vector field is defined as:


$$
\nabla \cdot \mathbf{J}(x, t) = \sum_{i=1}^n \frac{\partial J_i(x, t)}{\partial x_i}
$$


- If $\nabla \cdot \mathbf{J}(x, t) > 0$, more is **flowing out** than in → local decrease in $\rho$

- If $\nabla \cdot \mathbf{J}(x, t) < 0$, more is **flowing in** → local increase in $\rho$

- If $\nabla \cdot \mathbf{J}(x, t) = 0$, net flow is balanced → $\rho$ stays unchanged

  

This is a **local measure** of how much the vector field is “spreading out” at a point.



This geometric interpretation is essential: divergence at a point tells you whether the field is expanding (positive) or contracting (negative) at that location.



------



## **8. Changing the Order of Integration and Differentiation**

Why is:


$$
\frac{d}{dt} \int_V \rho(\mathbf{x}, t) \, d\mathbf{x} = \int_V \frac{\partial \rho(\mathbf{x}, t)}{\partial t} \, d\mathbf{x}?
$$


Because:


$$
\begin{align}

\frac{d}{dt} \int_V \rho(\mathbf{x}, t) \, d\mathbf{x} &= \lim_{\Delta t \to 0} \frac{\int_V \rho(\mathbf{x}, t + \Delta t) \, d\mathbf{x} - \int_V \rho(\mathbf{x}, t) \, d\mathbf{x}}{\Delta t} \\[2ex]

&= \lim_{\Delta t \to 0} \int_V \frac{\rho(\mathbf{x}, t + \Delta t) - \rho(\mathbf{x}, t)}{\Delta t} \, d\mathbf{x} \\[2ex]

&= \int_V \frac{\partial \rho(\mathbf{x}, t)}{\partial t} \, d\mathbf{x}

\end{align}
$$


This holds under the assumption that $\rho(\mathbf{x}, t)$ is smooth enough for the limit and integral to be interchanged.



---



## **9. Summary**

We began with:

- A physical intuition: conservation of quantities
- A model: fluid parcels moving in space
- A density function: $\rho(x, t)$
- A flux field: $\mathbf{J}(x, t)$
- A balance law: total change = net outflow
- Gauss theorem: surface integral becomes volume integral
- Commutation of derivative/integral: $\partial_t \int = \int \partial_t$

We concluded with:


$$
\frac{\partial \rho(x, t)}{\partial t} + \nabla \cdot (\rho(x, t) \cdot \mathbf{v}(x, t)) = 0
$$


The **continuity equation** arises naturally when we model a conserved quantity flowing through space. It reflects a deep idea:

> Any local change in the quantity must be explained by its flow into or out of that region.



This continuity equation is fundamental in physics and mathematics, appearing in fluid mechanics, electromagnetism, quantum mechanics, and beyond.