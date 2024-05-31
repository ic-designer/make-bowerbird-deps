define bowerbird::git-dependency # url, vesion, entry
    $(eval $(call bowerbird::deps::define-dependency-constants,DEPENDENCY_$(basename $(notdir $(1))),$(1),$(2),$(basename $(notdir $(1))),$(3)))
    $(DEPENDENCY_$(basename $(notdir $(1)))_PATH)/.:
		@echo "Cloning from '$($(1)_URL)'..."
		@git clone --config advice.detachedHead=false --depth 1 \
				--branch $(DEPENDENCY_$(basename $(notdir $(1)))_VERSION) \
				$(DEPENDENCY_$(basename $(notdir $(1)))_URL) \
				$(DEPENDENCY_$(basename $(notdir $(1)))_PATH)

    $(DEPENDENCY_$(basename $(notdir $(1))).MK): | $(DEPENDENCY_$(basename $(notdir $(1)))_PATH)/.
		@test -d $$|
		@test -f $$@ || (\
			\rm -rf $(DEPENDENCY_$(basename $(notdir $(1)))_PATH) && \
			>&2 echo "\nERROR: Expected entry point not found: $$@ \
			\nrm -rf $(DEPENDENCY_$(basename $(notdir $(1)))_PATH)\n" \
			&& exit 1\
		)
		@echo

    include $(DEPENDENCY_$(basename $(notdir $(1))).MK)
endef


define bowerbird::deps::define-constant # name, value
    ifndef $(1)
        $(1) = $(2)
    else
        ifneq ($($(1)),$(2))
            $$(error ERROR: Identified conflict with $(1): '$($(1))' != '$(2)' )
        endif
    endif
endef

define bowerbird::deps::define-dependency-constants # id, url, vesion, path, entry
    WORKDIR_DEPS ?= $$(error ERROR: Undefined variable WORKDIR_DEPS)
    $(eval $(call bowerbird::deps::define-constant,$(1)_URL,$(2)))
    $(eval $(call bowerbird::deps::define-constant,$(1)_VERSION,$(3)))
    $(eval $(call bowerbird::deps::define-constant,$(1)_PATH,$(abspath $(WORKDIR_DEPS)/$(4))))
    $(eval $(call bowerbird::deps::define-constant,$(1).MK,$(abspath $($(1)_PATH)/$(5))))
endef
