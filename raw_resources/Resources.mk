SHEETS = $(patsubst %.sheet, %, $(wildcard *.sheet))
PROJ_ROOT ?= ../giggle
TOOLS = $(PROJ_ROOT)/tools

all: $(SHEETS)

define SHEET_template
$(1)_DIR = $(1).sheet
$(1)_PSDS = $(wildcard $(1).sheet/*.psd)
$(1)_SCML = $(wildcard $(1).sheet/*.scml)
$(1)_PSDS_PNGS = $$(patsubst %.psd, %.png, $$($(1)_PSDS))

# if an order file exists, use that to define what files we care about
# and disable sorting
ifeq ($(wildcard $(1).sheet/order.txt),)
	$(1)_SORT = true
	$(1)_PNGS = $$(sort $(wildcard $(1).sheet/*.png) $$($(1)_PSDS_PNGS))
else
	$(1)_SORT = false
	$(1)_ORDER = $$(shell cat $(1).sheet/order.txt)
	$(1)_PNGS = $$(shell cat $(1).sheet/order.txt)
endif

$(1)_OUT = ../resources/$(1)
$(1)_SHEET_TARGETS = $$($(1)_OUT).png $$($(1)_OUT).dat
$(1)_SPRITER_TARGETS = $$(patsubst $(1).sheet/%.scml, ../resources/%.cs, $$($(1)_SCML))
$(1)_TARGETS = $$($(1)_SHEET_TARGETS) $$($(1)_SPRITER_TARGETS)
ALL_PNGS+=$$($(1)_PNGS)
ALL_TARGETS+=$$($(1)_TARGETS)

$$($(1)_SHEET_TARGETS): $$($(1)_PNGS) $$($(1)_DIR)/trim.txt $$($(1)_ORDER)
	python $(TOOLS)/spritepak.py $(PAK_O) $$($(1)_DIR)/trim.txt $$($(1)_SORT) $$($(1)_OUT) 1024 1024 $$($(1)_PNGS)

../resources/%.cs: $(1).sheet/%.scml
	python $(TOOLS)/spriterpak.py $$< $$@

$(1): $$($(1)_TARGETS)
endef

# instantiate the sheet template for all directories with .sheet in
# their names
$(foreach sheet,$(SHEETS),$(eval $(call SHEET_template,$(sheet))))

# on a mac, this rule will convert PSD files into PNGs flawlessly
%.png: %.psd
	osascript $(TOOLS)/psdconvert.scpt $(PWD)/$< $(PWD)/$@

clean:
	rm -rf $(ALL_TARGETS)

distclean: clean
