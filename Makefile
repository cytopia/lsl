# Unix Makefile

# ls
LSL_PY       = lsl.py
LSL_SH       = lsl.sh
# label manager
LBL          = lbl
# lbl modules
LBL_ADD      = add
LBL_EDIT     = edit
LBL_REN      = ren
LBL_DEL      = del
LBL_NAME     = name
LBL_REGEX    = regex
LBL_PATH     = path
LBL_CREATED  = created
LBL_MODIFIED = modified
LBL_ADMIN    = admin

# Configuration
SHELL = /bin/sh

MKDIR_P = mkdir -p

# Check if './configure' has been run
ifneq ("$(wildcard configure.in)","")
CONFIGURED = 1
include configure.in
else
CONFIGURED = 0
endif

# Check if 'make' has been run
ifneq ("$(wildcard Makefile.in)","")
MAKED = 1
else
MAKED = 0
endif


all:

ifeq ($(CONFIGURED),0)
$(error Not configured, run ./configure)
endif

	@touch Makefile.in

	@echo "finished."
	@echo "Type 'make install'"


help:
	@echo Options
	@echo "   make install"
	@echo "      Install everthing (might require root)"
	@echo ""
	@echo "   make uninstall"
	@echo "      Remove everything except the logfiles"
	@echo "      (might require root)"
	@echo ""
	@echo "   make clean"
	@echo "      Clean build"
	@echo ""
	@echo "   make help"
	@echo "      Show this help screen"


install:

ifeq ($(MAKED),0)
	$(error Run 'make' first or show help: 'make help')
endif


	@echo "Installing files"
	@echo ""

	@# Create directories
	${MKDIR_P} $(BINDIR)
	${MKDIR_P} $(MODDIR)
	${MKDIR_P} $(ETCDIR)

	@# Install binary
	install -m 0755 build/$(LSL_PY) $(BINDIR)/$(LSL_PY)
	install -m 0755 build/$(LSL_SH) $(BINDIR)/$(LSL_SH)
	install -m 0755 build/$(LBL)    $(BINDIR)/$(LBL)

	@# Install modules
	install -m 0755 build/mod/$(LBL_ADD)      $(MODDIR)/$(LBL_ADD)
	install -m 0755 build/mod/$(LBL_EDIT)     $(MODDIR)/$(LBL_EDIT)
	install -m 0755 build/mod/$(LBL_REN)      $(MODDIR)/$(LBL_REN)
	install -m 0755 build/mod/$(LBL_NAME)     $(MODDIR)/$(LBL_NAME)
	install -m 0755 build/mod/$(LBL_REGEX)    $(MODDIR)/$(LBL_REGEX)
	install -m 0755 build/mod/$(LBL_PATH)     $(MODDIR)/$(LBL_PATH)
	install -m 0755 build/mod/$(LBL_CREATED)  $(MODDIR)/$(LBL_CREATED)
	install -m 0755 build/mod/$(LBL_MODIFIED) $(MODDIR)/$(LBL_MODIFIED)
	install -m 0755 build/mod/$(LBL_ADMIN)    $(MODDIR)/$(LBL_ADMIN)

	@echo "----------------------------------------------------------------------"
	@echo "Installation complete:"
	@echo ""
	@echo "$(MODDIR)/$(LBL_ADD)"
	@echo "$(MODDIR)/$(LBL_EDIT)"
	@echo "$(MODDIR)/$(LBL_REN)"
	@echo "$(MODDIR)/$(LBL_NAME)"
	@echo "$(MODDIR)/$(LBL_REGEX)"
	@echo "$(MODDIR)/$(LBL_PATH)"
	@echo "$(MODDIR)/$(LBL_CREATED)"
	@echo "$(MODDIR)/$(LBL_MODIFIED)"
	@echo "$(MODDIR)/$(LBL_ADMIN)"
	@echo ""
	@echo "----------------------------------------------------------------------"
	@echo ""


uninstall:

	rm -f $(MODDIR)/$(LBL_ADD)
	rm -f $(MODDIR)/$(LBL_EDIT)
	rm -f $(MODDIR)/$(LBL_REN)
	rm -f $(MODDIR)/$(LBL_NAME)
	rm -f $(MODDIR)/$(LBL_REGEX)
	rm -f $(MODDIR)/$(LBL_PATH)
	rm -f $(MODDIR)/$(LBL_CREATED)
	rm -f $(MODDIR)/$(LBL_MODIFIED)
	rm -f $(MODDIR)/$(LBL_ADMIN)

	rm -f $(BINDIR)/$(LBL)
	rm -f $(BINDIR)/$(LSL_PY)
	rm -f $(BINDIR)/$(LSL_SH)


clean:

	rm -rf build/*
	rm -f configure.in
	rm -f Makefile.in

