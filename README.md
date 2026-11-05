# hanbinzheng.github.io

Source code of my personal website: <https://hanbinzheng.github.io/>

Built with [Jekyll](https://jekyllrb.com/) and the [al-folio](https://github.com/alshedivat/al-folio) theme (v1.x).

## Where things live

| What                       | File / folder                    |
| -------------------------- | -------------------------------- |
| Site name, URL, features   | `_config.yml`                    |
| About (home) page          | `_pages/about.md`                |
| Portrait                   | `assets/img/prof_pic.jpg`        |
| News on the home page      | `_news/*.md`                     |
| Blog posts                 | `_posts/YYYY-MM-DD-title.md`     |
| Projects                   | `_projects/*.md`                 |
| CV page (web version)      | `_data/cv.yml`                   |
| CV PDF (download button)   | `assets/pdf/cv.pdf`              |
| Social links (home footer) | `_data/socials.yml`              |
| Images / videos for posts  | `assets/img/`, `assets/video/`   |

The navbar shows the home page plus every page in `_pages/` with `nav: true`, sorted by `nav_order`.

## Writing a blog post

Create `_posts/2026-01-31-my-post.md`:

```markdown
---
layout: post
title: My Post
date: 2026-01-31 00:00:00+0800
description: One-line summary shown in the blog list.
tags: [probability]
categories: math
toc:
  sidebar: left
---

Inline math: $$e^{i\pi} + 1 = 0$$.

Display math (keep a blank line before and after, and no blank lines inside):

$$
\begin{align*}
f(x) &= x^2 \\
f'(x) &= 2x
\end{align*}
$$
```

Math tips (the Markdown engine is kramdown):

- Use `$$...$$` for **both** inline and display math. A `$$` block on its own lines becomes display math; `$$...$$` inside a sentence becomes inline math.
- Never leave a blank line inside a display-math block; it ends the block.
- Numbered equations: `\begin{equation} ... \label{eq:name} \end{equation}`, referenced with `$$\eqref{eq:name}$$`.

Images, GIFs and videos (put the file under `assets/`):

```liquid
{% include figure.liquid path="assets/img/my-plot.gif" class="img-fluid rounded" zoomable=true %}
{% include video.liquid path="assets/video/my-demo.mp4" class="img-fluid rounded" controls=true autoplay=true loop=true muted=true %}
{% include video.liquid path="https://www.youtube.com/embed/VIDEO_ID" class="img-fluid rounded" %}
```

## Previewing locally (macOS)

One-time setup (macOS's built-in Ruby is too old):

```bash
brew install ruby@3.3 imagemagick
```

```bash
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH" LANG=en_US.UTF-8
bundle config set --local path vendor/bundle
bundle install
```

Then, each time:

```bash
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH" LANG=en_US.UTF-8
bundle exec jekyll serve --livereload
```

and open <http://localhost:4000>.

## Publishing

Push to `main`. The GitHub Actions workflow `.github/workflows/deploy.yml` builds the site and pushes the result to the `gh-pages` branch, which GitHub Pages serves. In the repository settings, **Settings → Pages → Build and deployment** must be set to _Deploy from a branch_, branch `gh-pages`, folder `/ (root)`.
