test-git-dependency-bowerbird-deps-success:
	test ! -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps || rm -rf $(WORKDIR_TEST)/$@/deps/bowerbird-deps
	test ! -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps
	$(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_SUCCESS=true
	test -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps
	! test -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps/.git

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_SUCCESS
    $(call bowerbird::git-dependency,$(WORKDIR_TEST)/test-git-dependency-bowerbird-deps-success/deps/bowerbird-deps,\
			https://github.com/ic-designer/make-bowerbird-deps.git,main,bowerbird.mk)
endif


test-git-dependency-bowerbird-deps-bad-entry:
	! $(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_ENTRY=true
	! test -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_ENTRY
    $(call bowerbird::git-dependency,$(WORKDIR_TEST)/test-git-dependency-bowerbird-deps-bad-entry/deps/bowerbird-deps,\
			https://github.com/ic-designer/make-bowerbird-deps.git,main,)
endif


test-git-dependency-bowerbird-deps-bad-path:
	test ! -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps || rm -rf $(WORKDIR_TEST)/$@/deps/bowerbird-deps
	mkdir -p $(WORKDIR_TEST)/$@/deps/bowerbird-deps/.git
	! $(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_PATH=true

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_PATH
    $(call bowerbird::git-dependency,$(WORKDIR_TEST)/test-git-dependency-bowerbird-deps-bad-path/deps/bowerbird-deps,\
			https://github.com/ic-designer/make-bowerbird-deps.git,main,bowerbird.mk)
endif


test-git-dependency-bowerbird-deps-bad-url:
	! $(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_URL=true
	! test -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_URL
    $(call bowerbird::git-dependency,$(WORKDIR_TEST)/test-git-dependency-bowerbird-deps-bad-url/deps/bowerbird-deps,\
			,,main,bowerbird.mk)
endif


test-git-dependency-bowerbird-deps-bad-version:
	! $(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_VERSION=true
	! test -d $(WORKDIR_TEST)/$@/deps/bowerbird-deps

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_VERSION
        $(call bowerbird::git-dependency,$(WORKDIR_TEST)/test-git-dependency-bowerbird-deps-bad-version/deps/bowerbird-deps,\
			https://github.com/ic-designer/make-bowerbird-deps.git,,bowerbird.mk)
endif


.PHONY: FORCE
FORCE:
	:
