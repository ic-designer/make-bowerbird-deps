# Targets
PHONY: test-git-dependency
test-git-dependency: \
		test-git-dependency-bowerbird-deps-bad-entry \
		test-git-dependency-bowerbird-deps-bad-url \
		test-git-dependency-bowerbird-deps-bad-version \
		test-git-dependency-bowerbird-deps-success \


.PHONY: test-git-dependency-bowerbird-deps-success
test-git-dependency-bowerbird-deps-success:
	@$(MAKE) FORCE \
			TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_SUCCESS=true \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps \
			2>/dev/null 1>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_SUCCESS
    $(eval $(call bowerbird::git-dependency,\
			https://github.com/ic-designer/make-bowerbird-deps.git,main,bowerbird.mk))
endif


.PHONY: test-git-dependency-bowerbird-deps-bad-entry
test-git-dependency-bowerbird-deps-bad-entry:
	@! $(MAKE) FORCE \
			TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_ENTRY=true \
			WORKDIR_DEPS=$(WORKDIR_TEST)/$@/deps \
			2>/dev/null 1>/dev/null
	@! test -d $(WORKDIR_DEPS)/BOWERBIRD_DEPS_BAD_ENTRY
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_ENTRY
    $(eval $(call bowerbird::git-dependency,https://github.com/ic-designer/make-bowerbird-deps.git,main,))
endif


.PHONY: test-git-dependency-bowerbird-deps-bad-url
test-git-dependency-bowerbird-deps-bad-url:
	@! $(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_URL=true 2>/dev/null 1>/dev/null
	@! test -d $(WORKDIR_DEPS)/BOWERBIRD_DEPS_BAD_URL
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_URL
    $(eval $(call bowerbird::git-dependency,BOWERBIRD_DEPS_BAD_URL,,main,bad-entry.mk))
endif


.PHONY: test-git-dependency-bowerbird-deps-bad-version
test-git-dependency-bowerbird-deps-bad-version:
	@! $(MAKE) FORCE TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_VERSION=true 2>/dev/null 1>/dev/null
	@! test -d $(WORKDIR_DEPS)/BOWERBIRD_DEPS_BAD_VERSION
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

ifdef TEST_GIT_DEPENDENCY_BOWERBIRD_DEPS_BAD_VERSION
    $(eval $(call bowerbird::git-dependency,BOWERBIRD_DEPS_BAD_VERSION,https://github.com/ic-designer/make-bowerbird-deps.git,,bowerbird.mk))
endif


.PHONY: FORCE
FORCE:
	@:

https://github.com/ic-designer/make-bowerbird-deps.git,,bowerbird.mk))
