# Bowerbird Dependency Tools

[![Makefile CI](https://github.com/ic-designer/make-bowerbird-deps/actions/workflows/makefile.yml/badge.svg)](https://github.com/ic-designer/make-bowerbird-deps/actions/workflows/makefile.yml)


## Usage

The Bowerbird Dependency Tools provide convenient scripts for loading external
dependencies used by Make. The snippet below provides an example of how to use the
scripts.

```makefile
# Required Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Load Bowerbird Dependency Tools
BOWERBIRD_DEPS.MK := $(WORKDIR_DEPS)/BOWERBIRD_DEPS/bowerbird_deps.mk
$(BOWERBIRD_DEPS.MK):
	@curl --silent --show-error --fail --create-dirs -o $@ -L \
https://raw.githubusercontent.com/ic-designer/make-bowerbird-deps/\
de3c33b1d19ab50ff1bd9b8e6e6d3cf1a5d4d2c3/src/bowerbird-deps/bowerbird-deps.mk
include $(BOWERBIRD_DEPS.MK)

# Load Dependencies
$(eval $(call bowerbird::git-dependency,<id>,<url>,<version>,<entry>))
```
