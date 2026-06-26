# Makefile for building the NIME '26 talk slides
# Trimmed from https://github.com/smcclab/pandoc-course-template

PANDOC     = pandoc
OUTPUT_DIR = build
REFERENCES = references.bib
MAIN_MD    = opening-the-design-space.md
MAIN_HTML  = $(OUTPUT_DIR)/index.html

SLIDE_MDS    = $(wildcard *.md)
REVEAL_HTMLS = $(patsubst %.md,$(OUTPUT_DIR)/%.html,$(SLIDE_MDS))
BEAMER_PDFS  = $(patsubst %.md,$(OUTPUT_DIR)/%.pdf,$(SLIDE_MDS))

PANDOC_COMMON_OPTS = --standalone \
                     --slide-level 2 \
                     --citeproc \
                     --bibliography=$(REFERENCES) \
                     --csl=apa.csl \
                     -M link-citations=true \
                     --resource-path=.

REVEAL_OPTS = -t revealjs \
              -V controls=true \
              -V progress=true \
              -V center=false \
              -V width=1920 \
              -V height=1080 \
              -V margin=0.1 \
              -V transition=fade \
              -V backgroundTransition=fade \
              -V hash=true \
              -V history=false \
              -V slideNumber=true \
              --css reveal_dark.css

BEAMER_OPTS = -t beamer \
              -V aspectratio=169 \
              -V theme=metropolis \
              -V colortheme=owl \
              --pdf-engine=lualatex \
              -V mainfont="Noto Sans" \
              -V mainfontfallback="Noto Sans CJK SC:mode=harf;NotoColorEmoji:mode=harf" \
              --lua-filter=filters/beamer-background.lua

# beamer-sanzo288.tex is loaded via the markdown's header-includes (see the
# frontmatter), NOT --include-in-header: a command-line header-includes would
# override the metadata field and silently drop the background filter's
# preamble. TEXINPUTS lets lualatex find the palette file from its temp dir.
export TEXINPUTS := $(CURDIR):$(TEXINPUTS)

.PHONY: all
all: reveal beamer

.PHONY: reveal
reveal: $(OUTPUT_DIR) images videos $(OUTPUT_DIR)/reveal_dark.css $(REVEAL_HTMLS)

.PHONY: html
html: reveal $(MAIN_HTML)

$(MAIN_HTML): $(MAIN_MD) $(REFERENCES)
	$(PANDOC) $(PANDOC_COMMON_OPTS) $(REVEAL_OPTS) $< -o $@

$(OUTPUT_DIR)/%.html: %.md $(REFERENCES)
	$(PANDOC) $(PANDOC_COMMON_OPTS) $(REVEAL_OPTS) $< -o $@

.PHONY: beamer
beamer: $(OUTPUT_DIR) $(BEAMER_PDFS)

$(OUTPUT_DIR)/%.pdf: %.md $(REFERENCES) beamer-sanzo288.tex filters/beamer-background.lua
	$(PANDOC) $(PANDOC_COMMON_OPTS) $(BEAMER_OPTS) $< -o $@

# Images — copy alongside the HTML so relative paths resolve
IMG_FILES       := $(wildcard img/*.png img/*.jpg img/*.jpeg img/*.svg img/*.gif img/*.webp)
IMG_BUILD_FILES := $(patsubst img/%,$(OUTPUT_DIR)/img/%,$(IMG_FILES))

.PHONY: images
images: $(IMG_BUILD_FILES)

$(OUTPUT_DIR)/img/%: img/%
	@mkdir -p $(dir $@)
	cp $< $@

# Videos — fullscreen backgrounds for the instrument slides. Copied alongside
# the HTML like images. Empty until footage is dropped into video/.
VIDEO_FILES       := $(wildcard video/*.mp4 video/*.webm video/*.mov)
VIDEO_BUILD_FILES := $(patsubst video/%,$(OUTPUT_DIR)/video/%,$(VIDEO_FILES))

.PHONY: videos
videos: $(VIDEO_BUILD_FILES)

$(OUTPUT_DIR)/video/%: video/%
	@mkdir -p $(dir $@)
	cp $< $@

$(OUTPUT_DIR)/reveal_dark.css: css/reveal_dark.scss
	sass --style=compressed $< $@

$(OUTPUT_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)
