# set latexfile to the name of the main file without the .tex
latexfile = main
# put the names of figure files here.  include the .eps
figures = $(wildcard figures/*.pdf)

TEX = pdflatex

# support subdirectories
#VPATH = Figs
# keep .eps files in the same directory as the .fig files
#%.eps : %.fig
#	fig2dev -L eps $< > $(dir $< )$@

all : pdf

$(gnu-out-dirs) :
	mkdir $@

figures : $(figures)

$(latexfile).bbl : figures main.bib *.tex
	pdflatex $(latexfile).tex
	bibtex $(latexfile)

$(latexfile).pdf : figures *.tex $(latexfile).bbl
	while (pdflatex $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true ; \
	done

pdf : $(latexfile).pdf

# make can't know all the sourcefiles.  some file may not have
# sourcefiles, e.g. eps's taken from other documents. 
$(latexfile).tar.gz : $(figures) $(latexfile).tex $(referencefile).bib
	tar -czvf $(latexfile).tar.gz $^

tarball: $(latexfile).tar.gz


clean : 
	rm -f ${latexfile}.log ${latexfile}.aux ${latexfile}.pdf ${latexfile}.bbl ${latexfile}.toc ${latexfile}.lof ${latexfile}.out ${latexfile}.blg
	rm -f *.aux # safe ? maybe.
