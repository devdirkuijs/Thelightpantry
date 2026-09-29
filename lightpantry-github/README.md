# The Light Pantry — website

Static photography site (HTML + local images). Hosted on **Netlify** (auto-deploys from `main`).

## Images (fast thumbs, sharp lightbox)

Portfolio photos live in two sizes:

| Folder | Use | Typical size |
|--------|-----|----------------|
| `images/thumbs/` | Gallery grid + category cards | ~640px long edge, JPEG + WebP |
| `images/<name>.jpg` + `images/full/<name>.webp` | Lightbox / zoom | ≤1600px long edge |

Also: `images/logo-hero.{jpg,webp}` (hero), `images/about-jonelle.{jpg,webp}` (about).

### Add a new photo

1. Put the original JPEG in `lightpantry-github/images/inbox/`
2. From `lightpantry-github/` run: `./scripts/optimize-images.sh`
3. In `index.html`, find `GALLERIES` and append e.g. `"images/people-21.jpg",`
4. Commit — Netlify deploys automatically

Requires ImageMagick (`convert`) and `cwebp` locally.

## Netlify

- Base directory: `lightpantry-github`
- `netlify.toml` publish = `.`
- `_headers` caches `/images/*` for 1 year; HTML revalidates immediately
