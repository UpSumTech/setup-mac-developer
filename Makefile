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

SRC_FILES := $(call rfind,src/,[^.]*.sh)

DEPS_STATEFILE = .make/done_deps

OS := $(call get_os)

HOST_IP :=

##########################################################################################
## Public targets

.DEFAULT_GOAL := build
.PHONY : deps build clean help

deps : $(DEPS_STATEFILE)

build : $(SRC_FILES)
ifeq ($(OS),'MAC')
	$(AT)./bin/provision.py
else
	$(error You are only allowed to run this on mac osx)
endif

clean:
	$(AT)rm -rf .make

help :
	echo make deps # install dependancies
	echo make build HOST_IP=<172.20.16.8> # This is a dry run to build the workstation on a host ip or on localhost
	echo make clean # remove cache and temp dirs
	echo make help # help menu

##########################################################################################
## Plumbing

$(DEPS_STATEFILE) :
	mkdir -p .make
	touch $(DEPS_STATEFILE)
