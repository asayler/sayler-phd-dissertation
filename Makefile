REPORT=proposal
LATEX=pdflatex
BIBTEX=bibtex
REF1=refs

CLS = $(wildcard *.cls)
TEX = $(wildcard *.tex)
REFS = $(REF1).bib
SRCS = $(TEX) $(REFS)

FIG_TMP = tmp.eps
FIGS = $(patsubst %, figs/out/%.pdf, TrustModel-Seperated TrustModel-Traditional \
         Arch-Sharded App-FileStore App-DataRepo App-SecureEmail)

all: pdf

figs: $(FIGS)

pdf: $(SRCS) $(CLS) figs
	$(LATEX) $(REPORT)
	$(BIBTEX) $(REPORT)
	$(LATEX) $(REPORT)
	$(LATEX) $(REPORT)

figs/out/%.pdf: figs/src/%.svg
	inkscape --export-area-drawing --export-eps="$(FIG_TMP)" --file="$<"
	epstopdf "$(FIG_TMP)" --outfile="$@"
	rm "$(FIG_TMP)"

clean:
	$(RM) figs/out/*
	$(RM) *.dvi *.aux *.log *.blg *.bbl *.out *.lof *.lot *.toc
	$(RM) *~ .*~
