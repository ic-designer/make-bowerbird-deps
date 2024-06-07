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
53e2060a65686ec7e30bffa6079fc531c1eabbbc/src/bowerbird-deps/bowerbird-deps.mk
include $(BOWERBIRD_DEPS.MK)

# Load Dependencies
$(eval $(call bowerbird::git-dependency,<id>,<url>,<version>,<entry>))
```

## Macros

### `bowerbird::git-dependency`

```
bowerbird::git-dependency,<path>,<url>,<version>,<entry>

  Installs a bowerbird compatible git dependency for immediate use. This command will
  clone the dependency repo from the designated URL location into the specified path.
  The commands performs a shallow clone and deletes the git history of the clone to
  prevent against accidental changes in the cloned repo.

  Args:
      path: Path where the dependency repo is cloned.
      url: Location of the repo specified as a URL.
      version: Version of the repo specified as a tag or branch name.
      entry: Entry point of the repo specified as a relative file path.

  Error:
      If the specified entry point cannot be created, the command will remove all
          partially installed files and terminate with exit 1.
      If the specified path is not empty, the cloning operation will fail and return
          a non-zero exit code.


  Example:
      $(eval $(call bowerbird::git-dependency,deps/bowerbird-deps,\
              https://github.com/ic-designer/make-bowerbird-deps.git,\
              main,bowerbird.mk))
```
