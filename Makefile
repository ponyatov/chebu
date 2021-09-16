# \ var
MODULE  = $(notdir $(CURDIR))
OS      = $(shell uname -s)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
MONTH   = $(shell LANG=C date +%b%y)
# / var

# \ dir
CWD     = $(CURDIR)
BIN     = $(CWD)/bin
DOC     = $(CWD)/doc
LIB     = $(CWD)/lib
SRC     = $(CWD)/src
TMP     = $(CWD)/tmp
PYPATH  = $(HOME)/.local/bin
# / dir

# \ tool
CURL    = curl -L -o
PY      = $(shell which python3)
PIP     = $(shell which pip3)
PEP     = $(PYPATH)/autopep8
PYT     = $(PYPATH)/pytest
LATEX   = pdflatex -halt-on-error --output-dir=$(TMP)
# / tool

# \ src
Y   += $(MODULE).metaL.py metaL.py
S   += $(Y)
TEX  = doc/$(MONTH).tex doc/header.tex doc/about.tex doc/bib.tex
S   += $(TEX)
# / src

# \ all

.PHONY: all
all: tmp/$(MODULE)_$(MONTH).pdf

tmp/$(MODULE)_$(MONTH).pdf: $(TEX) $(IMG)
	cd doc ; $(LATEX) $(MONTH) && $(LATEX) $(MONTH)

.PHONY: meta
meta: $(PY) $(MODULE).metaL.py
	$^
	$(MAKE) format

.PHONY: test
test:

format: tmp/format_py
tmp/format_py: $(Y)
	$(PEP) --ignore=E26,E302,E305,E401,E402,E701,E702 --in-place $?
	touch $@
# / all

# \ doc

.PHONY: doxy
doxy:
	rm -rf docs ; doxygen doxy.gen 1>/dev/null

.PHONY: doc
doc:
# / doc

# \ install
.PHONY: install update
install: $(OS)_install doc
	$(MAKE) update
update: $(OS)_update
	$(PIP) install --user -U pytest autopep8

.PHONY: Linux_install Linux_update
Linux_install Linux_update:
ifneq (,$(shell which apt))
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`
endif
# / install

# \ merge
MERGE  = Makefile README.md .gitignore apt.dev apt.txt doxy.gen $(S)
MERGE += .vscode bin doc lib src tmp

.PHONY: ponymuck
ponymuck:
	git push -v
	git checkout $@
	git pull -v

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout ponymuck -- $(MERGE)
	$(MAKE) doxy

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) ponymuck

.PHONY: zip
ZIP = $(TMP)/$(MODULE)_$(BRANCH)_$(NOW)_$(REL).src.zip
zip:
	git archive --format zip --output $(ZIP) HEAD
	$(MAKE) doxy ; zip -r $(ZIP) docs
# / merge
