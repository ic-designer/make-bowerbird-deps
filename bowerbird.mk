_PATH := $(dir $(lastword $(MAKEFILE_LIST)))
include $(_PATH)/src/bowerbird-deps/bowerbird-deps.mk
