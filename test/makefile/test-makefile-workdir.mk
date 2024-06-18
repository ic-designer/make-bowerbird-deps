test-workdir-root:
	$(call bashargs::test-workdir::build-helper)

test-workdir-deps: WORKDIR_DEPS=deps
test-workdir-deps:
	test "$(WORKDIR_DEPS)" = "deps"
	$(call bashargs::test-workdir::build-helper)


make-bowerbird/test-makefile-workdir/force:
	@:

define bashargs::test-workdir::build-helper
	$(MAKE) make-bowerbird/test-makefile-workdir/force \
			WORKDIR_ROOT=$(WORKDIR_TEST)/$@ \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/$(WORKDIR_DEPS)
	test -d $(WORKDIR_TEST)/$@/$(WORKDIR_DEPS)
	test -d $(WORKDIR_TEST)/$@/$(WORKDIR_DEPS)
endef
