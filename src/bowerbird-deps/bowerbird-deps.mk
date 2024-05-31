define bowerbird::git-dependency # id, url, vesion, entry
    $(eval $(call bowerbird::deps::define-dependency-constants,_DEP_$(1),$(2),$(3),$(1),$(4)))
    $(_DEP_$(1)_PATH)/.:
		@echo "Cloning from '$(_DEP_$(1)_URL)'..." >&2
		@git clone --config advice.detachedHead=false --depth 1 \
				--branch $(_DEP_$(1)_VERSION) \
				$(_DEP_$(1)_URL) \
				$(_DEP_$(1)_PATH)
		@rm -rf $(_DEP_$(1)_PATH)/.git


    $(_DEP_$(1).MK): | $(_DEP_$(1)_PATH)/.
		@test -d $$|
		@test -f $$@ || (\
			\rm -rf $(_DEP_$(1)_PATH) && \
			>&2 echo "\nERROR: Expected entry point not found: $$@ \
			\nrm -rf $(_DEP_$(1)_PATH)\n" \
			&& exit 1\
		)
		@echo

    include $(_DEP_$(1).MK)
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
