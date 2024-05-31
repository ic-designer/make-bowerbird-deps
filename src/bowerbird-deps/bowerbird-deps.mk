define bowerbird::git-dependency
    $(eval $(call bowerbird::deps::define-dependency-constants,DEPENDENCY_$(basename $(notdir $(1))),$(1),$(2),$(3)))
    $(DEPENDENCY_$(basename $(notdir $(1)))_DIR)/.:
		@echo "Cloning from '$($(1)_URL)'..."
		@git clone --config advice.detachedHead=false --depth 1 \
				--branch $(DEPENDENCY_$(basename $(notdir $(1)))_VERSION) \
				$(DEPENDENCY_$(basename $(notdir $(1)))_URL) \
				$(DEPENDENCY_$(basename $(notdir $(1)))_DIR)

    $(DEPENDENCY_$(basename $(notdir $(1))).MK): | $(DEPENDENCY_$(basename $(notdir $(1)))_DIR)/.
		@test -d $$|
		@test -f $$@ || (\
			\rm -rf $(DEPENDENCY_$(basename $(notdir $(1)))_DIR) && \
			>&2 echo "\nERROR: Expected entry point not found: $$@ \
			\nrm -rf $(DEPENDENCY_$(basename $(notdir $(1)))_DIR)\n" \
			&& exit 1\
		)
		@echo

    include $(DEPENDENCY_$(basename $(notdir $(1))).MK)
endef


define bowerbird::deps::define-constant
    ifndef $(1)
        $(1) = $(2)
    else
        ifneq ($($(1)),$(2))
            $$(error ERROR: Identified conflict with $(1): '$($(1))' != '$(2)' )
        endif
    endif
endef

define bowerbird::deps::define-dependency-constants
    WORKDIR_DEPS ?= $$(error ERROR: Undefined variable WORKDIR_DEPS)
    $(eval $(call bowerbird::deps::define-constant,$(1)_URL,$(2)))
    $(eval $(call bowerbird::deps::define-constant,$(1)_VERSION,$(3)))
    $(eval $(call bowerbird::deps::define-constant,$(1)_DIR,$(abspath $(WORKDIR_DEPS)/$(1))))
    $(eval $(call bowerbird::deps::define-constant,$(1).MK,$(abspath $($(1)_DIR)/$(4))))
endef
