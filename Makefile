REPORT=thesis
LATEX=pdflatex
BIBTEX=bibtex
REF1=refs

CLS = $(wildcard *.cls)
TEX = $(wildcard *.tex)
REFS = $(REF1).bib
SRCS = $(TEX) $(REFS)

FIG_TMP = tmp.eps
FIGS = $(patsubst %, figs/out/%.pdf, \
         App-DataRepo \
         App-FileLocker \
         App-FileStore \
         App-PKCS11 \
         App-SecureEmail \
         App-SSHAgent \
         App-SSHServer \
         Arch-Sharded \
         Custos-ACS \
         Custos-OU \
	     Custos-Overview \
         TrustModel-Seperated \
         TrustModel-Traditional \
         Tutamen-Op-Fetch \
         Tutamen-Op-Store \
         Tutamen-Structs-ACS \
         Tutamen-Structs-SS \
         Tutamen-System-Base \
         Tutamen-System-Distributed \
         )

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

bibsort: refs.bib
	bibtool -s -o ./refs.bib -i ./refs.bib

clean:
	$(RM) figs/out/*.pdf *.eps
	$(RM) *.dvi *.aux *.log *.blg *.bbl *.out *.lof *.lot *.toc
	$(RM) *~ .*~
