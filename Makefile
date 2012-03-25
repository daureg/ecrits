SOURCES = $(wildcard *.nv)
OBJECTS = $(SOURCES:.nv=)
SAVE=textes-`date +"%Y%m%d"`
JUST_TEX ?= 1

all: $(OBJECTS)
ifeq ($(JUST_TEX),1)
	cat result/*.tex > result/all.texx
	mv result/all.tex{x,}
	sed -i "s/\\\tiret/―/g" result/all.tex
	sed -i "s/\\\og/«/g" result/all.tex
	sed -i "s/\\\myfg/»/g" result/all.tex
	cp do_it.tex result/
	cd result; xelatex do_it.tex && xelatex do_it.tex && mv {do_it,oeuvres}.pdf
endif

%: %.nv
	cp $< script/
	cp info/$@.mk script/config/info.mk
ifeq ($(JUST_TEX),0)
	cd script; $(MAKE) -f Makefile NAME=$@ html_full txt xetex
	cd script; $(MAKE) -f Makefile NAME=$@ link
	cat script/link.htm >> result/links.html
	cp script/$@{.xhtml,.pdf,.txt,_plain.txt} result/
else
	cd script; $(MAKE) -f Makefile NAME=$@ MK_TEX_TITLE=1 print
	cp script/texte.tex result/$@.tex
endif
	cd script; $(MAKE) -f Makefile NAME=$@ distclean
	rm script/*.nv

archive:
	mkdir $(SAVE)
	cp $(SOURCES) $(SAVE)/
	cp -r info result $(SAVE)/
	tar caf $(SAVE).tar.lzma $(SAVE)/
	rm -rf $(SAVE)

clean:
	rm -f result/*
