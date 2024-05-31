define bowerbird::git-dependency
    $(eval $(call bowerbird::deps::define-dependency-constants,$(1),$(2),$(3),$(4)))

    $($(1)_DIR)/.:
		@echo "Cloning from '$($(1)_URL)'..."
		@git clone --config advice.detachedHead=false --depth 1 $($(1)_URL) --branch $($(1)) $($(1)_DIR)

    $($(1).MK): | $($(1)_DIR)/.
		@test -d $$|
		@test -f $$@ || (\
			rm -rf $($(1)_DIR) && \
			>&2 echo "ERROR: Expected entry point not found: $$@\nrm -rf $($(1)_DIR)\n" \
			&& exit 1\
		)
		@echo

    ifeq (,$(filter $($(1).MK),$(MAKECMDGOALS)))
        ifeq (,$(wildcard $($(1).MK)))
            $$(shell $(MAKE) $($(1).MK))
        endif
        ifeq (,$(wildcard $($(1).MK)))
            $$(error ERROR: Failed to generate expected include file '$($(1).MK)')
        endif
        include $($(1).MK)
    else
        -include $($(1).MK)
    endif
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
    $(eval $(call bowerbird::deps::define-constant,$(1),$(3)))
    $(eval $(call bowerbird::deps::define-constant,$(1)_URL,$(2)))
    $(eval $(call bowerbird::deps::define-constant,$(1)_DIR,$(abspath $(WORKDIR_DEPS)/$(1))))
    $(eval $(call bowerbird::deps::define-constant,$(1).MK,$(abspath $($(1)_DIR)/$(4))))
endef
