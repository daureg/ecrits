SOURCES = $(wildcard *.nv)
OBJECTS = $(SOURCES:.nv=)
SAVE=textes-`date +"%Y%m%d"`
JUST_TEX ?= 0

all: $(OBJECTS)

%: %.nv
	cp $< script/
	cp info/$@.mk script/config/info.mk
ifeq ($(JUST_TEX),0)
	cd script; $(MAKE) -f Makefile NAME=$@ html_full txt xetex
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
