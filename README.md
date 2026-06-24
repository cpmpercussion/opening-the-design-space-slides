# Opening the Design Space — slides

Source for the reveal.js slide deck accompanying the NIME '26 talk *Opening the
Design Space: Two Years of Performance with Intelligent Musical Instruments* by
Charles Patrick Martin (ANU).

**View online:** https://charlesmartin.au/opening-the-design-space-slides/

## Build

```
make reveal    # build the reveal.js HTML deck into build/
make beamer    # build the Beamer PDF (needs lualatex + Noto fonts)
make           # both
```

Building requires [pandoc](https://pandoc.org) and [Dart Sass](https://sass-lang.com).

## Publishing

Every push to `main` triggers `.github/workflows/deploy.yml`, which runs
`make all` inside a `pandoc/latex` container — building both the reveal.js HTML
deck and the Beamer PDF — and deploys them to GitHub Pages. Nothing is built
locally; the PDF download on the published site is generated in CI alongside
the HTML.

## Source

These files mirror the `slides/` directory of the paper repository, with the
bibliography (`references.bib`) copied in so the deck builds standalone.
