SOURCES = $(wildcard *.nv)
OBJECTS = $(SOURCES:.nv=)

all: $(OBJECTS)

%: %.nv
	cp $< script/
	cp info/$@.mk script/config/info.mk
	cd script; $(MAKE) -f Makefile NAME=$@ html_full txt xetex
	cp script/$@{.xhtml,.pdf,.txt,_plain.txt} result/
	cd script; $(MAKE) -f Makefile NAME=$@ distclean
	rm script/*.nv

clean:
	rm -f result/*
