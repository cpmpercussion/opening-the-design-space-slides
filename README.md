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
`make reveal` and deploys the result to GitHub Pages. The HTML deck is built
fresh in CI; `opening-the-design-space.pdf` (the Beamer version) is committed as
an asset and shipped alongside it — regenerate it with `make beamer` and commit
when the slides change.

## Source

These files mirror the `slides/` directory of the paper repository, with the
bibliography (`references.bib`) copied in so the deck builds standalone.
