---
layout: page
title: MeanFlow for Image Inverse Problems
description: One-step image denoising by starting MeanFlow from noisy images instead of Gaussian noise.
github: https://github.com/hanbinzheng/mf-img-denoising
importance: 2
category: research
---

_Undergraduate research at ZJUI, advised by [Prof. Xiangming Meng](https://zjui.intl.zju.edu.cn/en/team/teacherinfo/2082), Jun 2025 – Dec 2025._

MeanFlow models learn the _average_ velocity over a time interval, not the instantaneous velocity. This lets them generate a sample in a single step. In this project I changed the initial distribution of MeanFlow from a Gaussian to the distribution of **noisy images**. The model then learns a direct one-step map from a corrupted image to a clean one, which gives efficient one-step denoising.

**Code:** [github.com/hanbinzheng/mf-img-denoising](https://github.com/hanbinzheng/mf-img-denoising)
