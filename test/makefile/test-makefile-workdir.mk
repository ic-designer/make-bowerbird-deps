
test-workdir-root:
	$(MAKE) bowerbird/deps/test-makefile-workdir/force \
		WORKDIR_ROOT=$(WORKDIR_TEST)/$@/root
	test -d $(WORKDIR_TEST)/$@/root/deps

test-workdir-deps:
	$(MAKE) bowerbird/deps/test-makefile-workdir/force \
		WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps
	test -d $(WORKDIR_TEST)/$@/deps

bowerbird/deps/test-makefile-workdir/force:
	@:
