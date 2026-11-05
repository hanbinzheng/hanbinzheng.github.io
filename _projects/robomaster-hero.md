---
layout: page
title: RoboMaster Hero Robot
description: Real-time electrical control system on an STM32H723, with quaternion-based IMU orientation estimation.
github: https://github.com/hanbinzheng/hero
importance: 1
category: engineering
---

_Nov 2025 – Apr 2026. Our team won the Third Prize in the RoboMaster University League (Shanghai, 3v3)._

I built the electrical control system for my team's swerve-drive **hero robot** in the RoboMaster competition.

- **Embedded control.** A real-time control system on an **STM32H723** that runs high-frequency control loops and integrates the robot's peripheral hardware.
- **Orientation estimation.** I derived the **quaternion kinematics** and implemented a **Mahony filter** from scratch to fuse IMU measurements, which gives stable orientation tracking. The orientation $$q$$ evolves as

$$
\dot{q} = \frac{1}{2}\, q \otimes \begin{bmatrix} 0 \\ \boldsymbol{\omega} \end{bmatrix},
$$

where $$\boldsymbol{\omega}$$ is the gyroscope's angular velocity. The Mahony filter adds a feedback correction to $$\boldsymbol{\omega}$$ computed from the accelerometer's estimate of the gravity direction.

**Code:** [github.com/hanbinzheng/hero](https://github.com/hanbinzheng/hero)
