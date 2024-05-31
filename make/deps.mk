# Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Load Dependencies
include src/bowerbird-deps/bowerbird-deps.mk
$(eval $(call bowerbird::git-dependency,BOWERBIRD_HELP,https://github.com/ic-designer/make-bowerbird-help.git,main,bowerbird.mk))
$(eval $(call bowerbird::git-dependency,BOWERBIRD_GIT,https://github.com/ic-designer/make-bowerbird-git.git,main,bowerbird.mk))
