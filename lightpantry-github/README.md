# The Light Pantry — Photography Website

Single-file static site for The Light Pantry photography (thelightpantry.co.za).

## Structure
- `index.html` — the entire website (HTML/CSS/JS in one file)
- `images/` — all portfolio photos, referenced by the galleries
- `netlify.toml` — tells Netlify to serve the site as-is (no build step)

## How to add a photo
1. Add the optimised image to the `images/` folder (e.g. `people-21.jpg`)
2. In `index.html`, find the `GALLERIES` section and add a line to the right category:
   `"images/people-21.jpg",`
3. Commit — Netlify auto-deploys within a minute.

## Deploys
Connected to Netlify. Every commit to `main` publishes automatically.
