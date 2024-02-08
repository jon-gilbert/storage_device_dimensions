
export ROOT ?= $(abspath $(shell pwd))
export OUTPUT ?= $(ROOT)/output
MODS = $(wildcard sff-*XX)
ifeq ($(MODS),)
$(info Warning: no modules found. This Makefile is for the top level directory. Did you mean to use Makefile.scads?)
endif


all: $(MODS)

$(MODS): $(OUTPUT)
	cp $(ROOT)/.openscad_docsgen_rc $@
	$(MAKE) -f $(ROOT)/Makefile.scads -C $@ all

$(OUTPUT):
	mkdir -p $(OUTPUT)/images

clean:
	for d in $(MODS); do $(MAKE) -f $(ROOT)/Makefile -C $$d clean; done
	rm -rf $(OUTPUT)

.PHONY: $(MODS) scads

.SECONDARY:

