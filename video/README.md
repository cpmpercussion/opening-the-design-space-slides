# Instrument background videos

Drop fullscreen background footage for the instrument slides here, then run
`make reveal` (or push to rebuild). The Makefile copies everything in this
directory into `build/video/`, and the deploy workflow ships it to the site.

Expected filenames (referenced from `opening-the-design-space.md`):

| Slide                     | File              |
| ------------------------- | ----------------- |
| The Intelligent Volca     | `volca.mp4`       |
| The Intelligent MicroFreak| `microfreak.mp4`  |
| The Intelligent S-1       | `s-1.mp4`         |
| The Intelligent DAW       | `daw.mp4`         |
| The Intelligent Setup     | `setup.mp4`       |

Tips for reveal.js background video:

- Use H.264 `.mp4` (broadest browser support); `.webm` also works.
- They loop muted and are scaled with `background-size="cover"`, so frame for
  a 16:9 fill — edges may be cropped.
- Keep files reasonably small; they're committed to the repo and served from
  GitHub Pages.
