# using xelatex to compile the tex file
# this requires having installed the JuliaMono font in your system beforehand
#
# use make LATEX=pdflatex to use pdflatex instead

XELATEX = xelatex -shell-escape -8bit
PDFLATEX = pdflatex -shell-escape

COMMAND = $(XELATEX)

ifeq ($(LATEX), pdflatex)
	COMMAND = $(PDFLATEX)
endif

###

DOCUMENTS = \
	syntaxe/syntaxe.pdf \
	types/types.pdf \
	dispatch/dispatch.pdf \
	TDsyntaxe/TDsyntaxe.pdf \
	TDtypes/TDtypes.pdf \
	TDdispatch/TDdispatch.pdf \

all: $(DOCUMENTS)

clean:
	rm -f {.,*}/*.{aux,log,nav,out,snm,toc,vrb}

superclean:
	rm -f $(DOCUMENTS)

# not quite required, but useful:
# create a symlink to find the figures when running from the local directory
symlinks:
	@dirs=$$(find . -type d -depth 1 | grep -E -v './.git|minted|figures'); \
	for d in $$dirs; do \
		if [[ -d $$d/figures ]]; then \
			echo $$d/figures already exists; \
		else \
			echo creating symlink in $$d; \
			ln -s ../figures $$d; \
		fi \
	done

# dispatch/dispatch.pdf: dispatch/dispatch.tex
# 	 dispatch/dispatch.tex


# move result in its directory
%.pdf : %.tex
	$(COMMAND) $<
	mv $(notdir $(<:.tex=.pdf)) $@

list-docs:
	@echo $(DOCUMENTS)

view-docs:
	open $(DOCUMENTS)
