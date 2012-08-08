LATEX=latex
BIBTEX=bibtex
DVIPS=dvips
PS2PDF=ps2pdf
INPUT=main
OUTPUT=main

all: dviclean $(OUTPUT).ps $(BIBTEX).bib $(OUTPUT).pdf
pdf: dviclean $(OUTPUT).pdf $(BIBTEX).bib $(OUTPUT).pdf

$(OUTPUT).pdf: $(OUTPUT).ps
	$(PS2PDF) $(OUTPUT).ps > $(OUTPUT).pdf

$(OUTPUT).ps: $(INPUT).dvi
	$(DVIPS) -t letter -f $(INPUT).dvi > $(OUTPUT).ps

$(INPUT).dvi: $(INPUT).tex
	$(LATEX) $(INPUT).tex

$(BIBTEX).bib: $(INPUT).bib
	$(BIBTEX) $(INPUT)

clean:
	/bin/rm -f *.dvi *.aux *~ *.log *.lot *.lof *.toc *.blg *.bbl 
dviclean:
	/bin/rm -f *.dvi 

