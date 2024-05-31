# Targets
PHONY: test-define-dependency-constants
test-define-dependency-constants: \
		test-define-one-dependency-directory \
		test-define-one-dependency-entry \
		test-define-one-dependency-url \
		test-define-one-dependency-version \
		test-define-second-dependency-conflicting-directory \
		test-define-second-dependency-conflicting-entry \
		test-define-second-dependency-conflicting-url \
		test-define-second-dependency-conflicting-version \


.PHONY: test-define-one-dependency-directory
test-define-one-dependency-directory:
	@$(MAKE) def-one-dependency-directory
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-directory
def-one-dependency-directory: WORKDIR_DEPS = deps/
def-one-dependency-directory:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,version,entry.mk))
	@test $(ID_DIR) = $(abspath deps/ID)


.PHONY: test-define-one-dependency-entry
test-define-one-dependency-entry:
	@$(MAKE) def-one-dependency-entry
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-entry
def-one-dependency-entry: WORKDIR_DEPS = deps/
def-one-dependency-entry:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,version,entry.mk))
	@test $(ID.MK) = $(abspath deps/ID/entry.mk)


.PHONY: test-define-one-dependency-url
test-define-one-dependency-url:
	@$(MAKE) def-one-dependency-url
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-url
def-one-dependency-url: WORKDIR_DEPS = deps/
def-one-dependency-url:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,version,entry.mk))
	@test $(ID_URL) = url/dependency.git


.PHONY: test-define-one-dependency-version
test-define-one-dependency-version:
	@$(MAKE) def-one-dependency-version
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-version
def-one-dependency-version: WORKDIR_DEPS = deps/
def-one-dependency-version:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,version,entry.mk))
	@test $(ID_VERSION) = version


.PHONY: test-define-second-dependency-conflicting-directory
test-define-second-dependency-conflicting-directory:
	@! $(MAKE) def-second-dependency-conflicting-directory 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-directory
def-second-dependency-conflicting-directory: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-directory:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/alpha.git,version,entry.mk))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/beta.git,version,entry.mk))


.PHONY: test-define-second-dependency-conflicting-entry
test-define-second-dependency-conflicting-entry:
	@! $(MAKE) def-second-dependency-conflicting-entry 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-entry
def-second-dependency-conflicting-entry: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-entry:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,version,alpha.mk))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,version,beta.mk))


.PHONY: test-define-second-dependency-conflicting-url
test-define-second-dependency-conflicting-url:
	@! $(MAKE) def-second-dependency-conflicting-url 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-url
def-second-dependency-conflicting-url: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-url:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/alpha.git,version,entry.mk))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/beta.git,version,entry.mk))
	@test $(ID_URL) = url/dependency.git


.PHONY: test-define-second-dependency-conflicting-version
test-define-second-dependency-conflicting-version:
	@! $(MAKE) def-second-dependency-conflicting-version 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-version
def-second-dependency-conflicting-version: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-version:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,alpha,entry.mk))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/dependency.git,beta,entry.mk))
