# Targets
PHONY: test-define-dependency-constants
test-define-dependency-constants: \
		test-define-one-dependency-entry \
		test-define-one-dependency-path \
		test-define-one-dependency-url \
		test-define-one-dependency-version \
		test-define-second-dependency-conflicting-entry \
		test-define-second-dependency-conflicting-path \
		test-define-second-dependency-conflicting-url \
		test-define-second-dependency-conflicting-version \


.PHONY: test-define-one-dependency-entry
test-define-one-dependency-entry:
	@$(MAKE) def-one-dependency-entry
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-entry
def-one-dependency-entry: WORKDIR_DEPS = deps/
def-one-dependency-entry:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	@test $(ID.MK) = $(abspath deps/path/entry)


.PHONY: test-define-one-dependency-path
test-define-one-dependency-path:
	@$(MAKE) def-one-dependency-path
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-path
def-one-dependency-path: WORKDIR_DEPS = deps/
def-one-dependency-path:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	@test $(ID_PATH) = $(abspath deps/path)


.PHONY: test-define-one-dependency-url
test-define-one-dependency-url:
	@$(MAKE) def-one-dependency-url
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-url
def-one-dependency-url: WORKDIR_DEPS = deps/
def-one-dependency-url:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	@test $(ID_URL) = url


.PHONY: test-define-one-dependency-version
test-define-one-dependency-version:
	@$(MAKE) def-one-dependency-version
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-one-dependency-version
def-one-dependency-version: WORKDIR_DEPS = deps/
def-one-dependency-version:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	@test $(ID_VERSION) = version


.PHONY: test-define-second-dependency-conflicting-entry
test-define-second-dependency-conflicting-entry:
	@! $(MAKE) def-second-dependency-conflicting-entry 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-entry
def-second-dependency-conflicting-entry: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-entry:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,entry/alpha))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,entry/beta))


.PHONY: test-define-second-dependency-conflicting-path
test-define-second-dependency-conflicting-path:
	@! $(MAKE) def-second-dependency-conflicting-path 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-path
def-second-dependency-conflicting-path: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-path:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path/alpha,version,entry))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path/beta,version,entry))


.PHONY: test-define-second-dependency-conflicting-url
test-define-second-dependency-conflicting-url:
	@! $(MAKE) def-second-dependency-conflicting-url 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-url
def-second-dependency-conflicting-url: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-url:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/alpha,version,entry))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/beta,version,entry))


.PHONY: test-define-second-dependency-conflicting-version
test-define-second-dependency-conflicting-version:
	@! $(MAKE) def-second-dependency-conflicting-version 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY:def-second-dependency-conflicting-version
def-second-dependency-conflicting-version: WORKDIR_DEPS = deps/
def-second-dependency-conflicting-version:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path,version/alpha,entry))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path,version/beta,entry))
