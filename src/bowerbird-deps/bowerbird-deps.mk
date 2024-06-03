define bowerbird::git-dependency # id, url, vesion, entry
    $(eval $(call bowerbird::deps::define-dependency-constants,BOWERBIRD_DEPENDENCY/$1,$2,$3,$1,$4))
    $(BOWERBIRD_DEPENDENCY/$1/PATH)/.:
		@git clone --config advice.detachedHead=false --depth 1 \
				--branch $(BOWERBIRD_DEPENDENCY/$1/VERSION) \
				$(BOWERBIRD_DEPENDENCY/$1/URL) \
				$(BOWERBIRD_DEPENDENCY/$1/PATH) \
                1>/dev/null \
                2>/dev/null
		@test -n $(BOWERBIRD_DEPENDENCY/$1/PATH)
		@test -d $(BOWERBIRD_DEPENDENCY/$1/PATH)/.git
		@rm -rf $(BOWERBIRD_DEPENDENCY/$1/PATH)/.git


    $(BOWERBIRD_DEPENDENCY/$1.MK): | $(BOWERBIRD_DEPENDENCY/$1/PATH)/.
		@test -d $$|
		@test -f $$@ || (\
			\rm -rf $(BOWERBIRD_DEPENDENCY/$1/PATH) && \
			>&2 echo "\nERROR: Expected entry point not found: $$@ \
			\nrm -rf $(BOWERBIRD_DEPENDENCY/$1/PATH)\n" \
			&& exit 1\
		)

    include $(BOWERBIRD_DEPENDENCY/$1.MK)
endef


define bowerbird::deps::define-constant # name, value
    ifndef $1
        $1 = $2
    else
        ifneq ($($1),$2)
            $$(error ERROR: Identified conflict with $1: '$($1)' != '$2' )
        endif
    endif
endef

define bowerbird::deps::define-dependency-constants # id, url, vesion, path, entry
    WORKDIR_DEPS ?= $$(error ERROR: Undefined variable WORKDIR_DEPS)
    $(eval $(call bowerbird::deps::define-constant,$1/URL,$2))
    $(eval $(call bowerbird::deps::define-constant,$1/VERSION,$3))
    $(eval $(call bowerbird::deps::define-constant,$1/PATH,$(abspath $(WORKDIR_DEPS)/$4)))
    $(eval $(call bowerbird::deps::define-constant,$1.MK,$(abspath $($1/PATH)/$5)))
endef
