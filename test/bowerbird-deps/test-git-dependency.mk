test-git-dependency-bowerbird-deps-success:
	mkdir -p $(WORKDIR_TEST)/$@
	$(MAKE) FORCE \
			TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_SUCCESS=true \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps \
			1>$(WORKDIR_TEST)/$@/$@.stdout.txt \
			2>$(WORKDIR_TEST)/$@/$@.stderr.txt
	test -d $(WORKDIR_TEST)/$@/deps/MAKE_BOWERBIRD_DEPS

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_SUCCESS
    $(eval $(call bowerbird::git-dependency,MAKE_BOWERBIRD_DEPS,\
			https://github.com/ic-designer/make-bowerbird-deps.git,main,bowerbird.mk))
endif


test-git-dependency-bowerbird-deps-bad-entry:
	mkdir -p $(WORKDIR_TEST)/$@
	! $(MAKE) FORCE \
			TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_ENTRY=true \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps \
			1>$(WORKDIR_TEST)/$@/$@.stdout.txt \
			2>$(WORKDIR_TEST)/$@/$@.stderr.txt
	! test -d $(WORKDIR_TEST)/$@/deps/MAKE_BOWERBIRD_DEPS

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_ENTRY
    $(eval $(call bowerbird::git-dependency,MAKE_BOWERBIRD_DEPS,\
			https://github.com/ic-designer/make-bowerbird-deps.git,main,))
endif


test-git-dependency-bowerbird-deps-bad-url:
	mkdir -p $(WORKDIR_TEST)/$@
	! $(MAKE) FORCE \
			TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_URL=true \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps \
			1>$(WORKDIR_TEST)/$@/$@.stdout.txt \
			2>$(WORKDIR_TEST)/$@/$@.stderr.txt
	! test -d $(WORKDIR_TEST)/$@/deps/MAKE_BOWERBIRD_DEPS

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_URL
    $(eval $(call bowerbird::git-dependency,MAKE_BOWERBIRD_DEPS,,main,bowerbird.mk))
endif


test-git-dependency-bowerbird-deps-bad-version:
	mkdir -p $(WORKDIR_TEST)/$@
	! $(MAKE) FORCE \
			TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_VERSION=true \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps \
			1>$(WORKDIR_TEST)/$@/$@.stdout.txt \
			2>$(WORKDIR_TEST)/$@/$@.stderr.txt
	! test -d $(WORKDIR_TEST)/$@/deps/MAKE_BOWERBIRD_DEPS

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_VERSION
        $(eval $(call bowerbird::git-dependency,MAKE_BOWERBIRD_DEPS,\
			https://github.com/ic-designer/make-bowerbird-deps.git,,bowerbird.mk))
endif


.PHONY: FORCE
FORCE:
	:
