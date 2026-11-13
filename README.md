# hanbinzheng.github.io

Source code of my personal website: <https://hanbinzheng.github.io/>

Built with [Jekyll](https://jekyllrb.com/) and the [al-folio](https://github.com/alshedivat/al-folio) theme (v1.x).

## Where things live

| What                         | File / folder                         |
| ---------------------------- | ------------------------------------- |
| Site name, URL, features     | `_config.yml`                         |
| About (home) page            | `_pages/about.md`                     |
| Portrait                     | `assets/img/prof_pic.jpg`             |
| Blog posts                   | `_posts/YYYY-MM-DD-title.html`        |
| Blog list / tags pages       | `_pages/blog.html`, `_pages/blog-tags.html` |
| Blog look (layouts, CSS)     | `_layouts/blog-*.liquid`, `assets/blog/blog.css` |
| Project pages (`/project/`)  | `_pages/project.html` (list), `_projects/<name>.html` (one page each, served at `/project/<name>/`); look: `_layouts/project-base.liquid`, `assets/project/project.css`; media: `assets/project/<name>/` |
| CV link in the navbar        | `_pages/cv.md` (links to the PDF in the `cv` repo) |
| Social links (home footer)   | `_data/socials.yml`                   |
| Images / videos for posts    | `assets/img/`, `assets/video/`        |
| News on the home page (off)  | create `_news/*.md`, then set `announcements.enabled: true` in `_pages/about.md` |

The navbar shows the home page plus every page in `_pages/` with `nav: true`, sorted by `nav_order`.
A page whose `permalink` is a full URL (like `_pages/cv.md`) becomes an external link.

The about page uses the al-folio theme. The blog uses its own layouts,
styled after [Lil'Log](https://lilianweng.github.io/).

## Writing a blog post

Posts are plain HTML with a small header. Create `_posts/2026-01-31-my-post.html`:

```html
---
layout: blog-post
title: My Post
date: 2026-01-31 00:00:00 +0800
description: One-line summary shown in the blog list.
tags: [probability, gaussian]
---

<p>Inline math: \(e^{i\pi} + 1 = 0\) or $e^{i\pi} + 1 = 0$.</p>

<h2 id="first-section">First section</h2>

\[
\begin{align}
f(x) &amp;= x^2 \\
f'(x) &amp;= 2x \label{eq:deriv}
\end{align}
\]

<p>Equation \(\eqref{eq:deriv}\) is numbered automatically.</p>

<h3 id="a-subsection">A subsection</h3>

{% highlight python %}
print("code blocks are highlighted")
{% endhighlight %}
```

- Give every `<h2>` / `<h3>` an `id`. They make up the "Table of Contents" box.
- Inside math, write `&` as `&amp;` and `<` as `&lt;` (it is HTML). MathJax still sees `&` and `<`.
- A literal dollar sign in text must be written `\$`.
- Optional header fields: `toc: false`, `math: false`. End a post with a `<h2 id="references">References</h2>` section (see the existing posts).

Images, GIFs and videos (put the file under `assets/`):

```html
<figure>
  <img src="/assets/img/my-plot.gif" alt="..." style="width: 80%">
  <figcaption>Caption, which can contain math like \(x^2\).</figcaption>
</figure>

<figure>
  <video src="/assets/video/my-demo.mp4" controls autoplay loop muted playsinline style="width: 80%"></video>
  <figcaption>A video.</figcaption>
</figure>
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
