---
title: "Simple Pendulum"
date: 2025-05-13 +0800
categories: [Physics, Mechanics]
math: true
pin: false
---

This is a very basic summary of simple pendulum. I wrote this only for a brief review of LaTeX syntax. For more serious one, refer to [this article](https://zhuanlan.zhihu.com/p/138339027).

## Torsion Pendulum

![](/assets/img/2025-05-13-Simple-Pendulum/image1.png)

We hope to find the moving function. i.e. $$ \theta $$ and $$ t $$ .

$$
\begin{align}
\vec{\tau} &= -\kappa \vec{\theta} \\
\vec{\tau} &=  I \vec{\alpha}  
\end{align}
$$


From definition, we know that:

$$
\ddot{\theta} = \alpha
$$

So, we obtain the final function:

$$
\ddot{\theta} = - \frac{\kappa}{I} \theta
$$

and the final result:

$$
\theta = \theta_0 \cdot \sin \left( \sqrt{\frac{\kappa}{I}}t + \phi \right) \quad(*1)
$$

## Pendulum

![](/assets/img/2025-05-13-Simple-Pendulum/image2.png)

We define the $$ R_{CM} $$ as the distance from the center of mass to the hanging point, which is only dependent on the shape.

We define $$ X_{CM} $$ the displacement from central axis to the current position (careful for the direction).

$$
\begin{align}
\vec{\tau} &= \overrightarrow{R_{CM}} \times \overrightarrow{G} \\
&= \overrightarrow{X_{CM}} \times \overrightarrow{G}
\end{align}
$$

Only consider the case that $$ \theta $$ is small enough, and only consider the magnitude, we have:

$$
X_{CM} = R_{CM} \sin{\theta} \approx R_{CM} \theta
$$


And if we consider the direction, for small $$\theta$$, 

$$
\overrightarrow{X_{CM}} \approx - \overrightarrow{R} \times \overrightarrow{\theta}
$$

Since 

$$
\vec{\tau} = I \vec{\alpha},
$$

Then we get the final formula (magnitude only):

$$
\begin{align}
\ddot{\theta} &\approx - \frac{R_{CM} \cdot Mg}{I} \theta \\
\Rightarrow 
\theta &= \theta_{0} \sin \left(  \sqrt{\frac{R_{CM} \cdot Mg}{I}} t \, + \phi  \right) \qquad (*2)
\end{align}
$$
