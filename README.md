# Ensemble SRD

Free System Reference Document of **Ensemble**, the narrative-first
tabletop RPG engine by Zotiquest Games, published at
<https://ensemblesrd.zotiquestgames.com/>.

Text under CC BY-SA 4.0. Ensemble is based on *Freeform Universal* by
Nathan Russell (CC BY 4.0).

## How this repo works

Same architecture as `zotiquestgames/lonersrd`.

- `content/` is the source of truth. It is written only by the workflow
  "Sync docs to public repos" in the private `zotiquestgames/loner`, which
  copies `ensemble/docs/` there on every change. Do not edit it here.
- `scripts/sync_content.py` runs before every render (Quarto `pre-render`).
  It turns `content/` into render-ready pages at the repo root (front matter,
  diagram paths) and writes the sidebar (`_sidebar-auto.yml`).
- `.github/workflows/publish.yml` renders the site with Quarto and publishes
  it to the `gh-pages` branch on every push to `main`. It skips the publish
  while `content/` has no texts.

## Adding a collection

When the first text of a new kind is promoted (for example the SRD into
`ensemble/docs/core/`):

1. Add an entry to `COLLECTIONS` in `scripts/sync_content.py` (folder,
   sidebar section, curated order).
2. Add its globs to `project.render` in `_quarto.yml` (`"core/*.md"`).
3. Add the generated folder to `.gitignore` (`/core/`).
4. Optionally add a card for it on `index.qmd` and a navbar entry.
