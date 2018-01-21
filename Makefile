##########################################################################################
## Functions

rfind = $(shell find '$(1)' -path '$(2)')
uname_s = $(shell uname -s)
get_os = $(if $(findstring Darwin,$(call uname_s)),MAC,OTHER)

##########################################################################################
## Variables

DEBUG := off
AT_off := @
AT_on :=
AT = $(AT_$(DEBUG))

SRC_FILES := $(call rfind,src/,[^.]*.sh) \
	$(call rfind,templates/,*)

DEPS_STATEFILE = .make/done_deps

OS := $(call get_os)

##########################################################################################
## Public targets

.DEFAULT_GOAL := install
.PHONY : deps install clean help

deps : $(DEPS_STATEFILE)

install : $(SRC_FILES)
ifeq ($(OS),'MAC')
	$(AT)./src/main.sh "$$@"
else
	$(error You are only allowed to run this on mac osx)
endif

clean:
	$(AT)rm -rf .make

help :
	echo make deps # install dependancies
	echo make install # This sets up a mac for development work
	echo make clean # This removes cache and temp dirs
	echo make help # help menu

##########################################################################################
## Plumbing

$(DEPS_STATEFILE) :
	mkdir -p .make
	touch $(DEPS_STATEFILE)
