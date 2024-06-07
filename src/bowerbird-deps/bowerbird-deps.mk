# bowerbird::git-dependency,<path>,<url>,<version>,<entry>
#
#   Installs a bowerbird compatible git dependency for immediate use. This command will
#   clone the dependency repo from the designated URL location into the specified path.
#   The commands performs a shallow clone and deletes the git history of the clone to
#   prevent against accidental changes in the cloned repo.
#
#   Args:
#       path: Path where the dependency repo is cloned.
#       url: Location of the repo specified as a URL.
#       version: Version of the repo specified as a tag or branch name.
#       entry: Entry point of the repo specified as a relative file path.
#
#   Error:
#       If the specified entry point cannot be created, the command will remove all
#           partially installed files and terminate with exit 1.
#       If the specified path is not empty, the cloning operation will fail and return
#           a non-zero exit code.
#
#
#   Example:
#       $(eval $(call bowerbird::git-dependency,deps/bowerbird-deps,\
#               https://github.com/ic-designer/make-bowerbird-deps.git,\
#               main,bowerbird.mk))
#
define bowerbird::git-dependency
    $$(eval $$(call bowerbird::deps::define-dependency-constants,BOWERBIRD_DEPENDENCY/$1,$2,$3,$1,$4))
    $$(BOWERBIRD_DEPENDENCY/$1/PATH)/.:
		@git clone --config advice.detachedHead=false --depth 1 \
				--branch $$(BOWERBIRD_DEPENDENCY/$1/VERSION) \
				$$(BOWERBIRD_DEPENDENCY/$1/URL) \
				$$(BOWERBIRD_DEPENDENCY/$1/PATH) \
                1>/dev/null \
                2>/dev/null || \
        (echo ERROR: Failed to clone dependency '$$(BOWERBIRD_DEPENDENCY/$1/URL)' && exit 1)
		@test -n $$(BOWERBIRD_DEPENDENCY/$1/PATH)
		@test -d $$(BOWERBIRD_DEPENDENCY/$1/PATH)/.git
		@rm -rf $$(BOWERBIRD_DEPENDENCY/$1/PATH)/.git


    $$(BOWERBIRD_DEPENDENCY/$1.MK): | $$(BOWERBIRD_DEPENDENCY/$1/PATH)/.
		@test -d $$|
		@test -f $$@ || (\
			\rm -rf $$(BOWERBIRD_DEPENDENCY/$1/PATH) && \
			>&2 echo "\nERROR: Expected entry point not found: $$@ \
			\nrm -rf $$(BOWERBIRD_DEPENDENCY/$1/PATH)\n" \
			&& exit 1\
		)

    include $$(BOWERBIRD_DEPENDENCY/$1.MK)
endef

# bowerbird::deps::define-constant,<name>,<value>
#
#   Helper macro for emulating the delacaration of a readonly constant. If the variable
#   designated by name does not exit, this command will create it and assign it to the
#   supplied value. If the variable already exists, this command throw an error it the
#   supplied value is different than the current value.
#
#   Args:
#       name: Name of the variable.
#       value: Value for the variable.
#
#   Error:
#       Raises an error if the variable designated by name already exists and the
#           supplied value for the variable is different than the current value of the
#           variable.
#
define bowerbird::deps::define-constant # name, value
    ifndef $1
        $1 := $2
    else
        ifneq ($$($1),$2)
            $$(error ERROR: Identified conflict with $1: '$$($1)' != '$2' )
        endif
    endif
endef

# bowerbird::deps::define-constant,<id>,<url>,<version>,<path>,<entry>
#
#   Helper macro for creating constants used by the git-dependency macros.

#   Args:
#       id: Unique id used as a prefix for the dependency constant names.
#       path: Path where the dependency repo is cloned.
#       url: Location of the repo specified as a URL.
#       version: Version of the repo specified as a tag or branch name.
#       entry: Entry point of the repo specified as a relative file path
#
#   Error:
#       Raises an error if the value for any of the constants is different than
#           previously supplied values.
#
define bowerbird::deps::define-dependency-constants # id, url, vesion, path, entry
    $$(eval $$(call bowerbird::deps::define-constant,$1/URL,$2))
    $$(eval $$(call bowerbird::deps::define-constant,$1/VERSION,$3))
    $$(eval $$(call bowerbird::deps::define-constant,$1/PATH,$$(abspath $4)))
    $$(eval $$(call bowerbird::deps::define-constant,$1.MK,$$($1/PATH)/$5))
endef
