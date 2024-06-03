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
a84d91d5d726ab8639b330b453a3d899556b480f/src/bowerbird-deps/bowerbird-deps.mk
include $(BOWERBIRD_DEPS.MK)

# Load Dependencies
$(eval $(call bowerbird::git-dependency,<id>,<url>,<version>,<entry>))
```
