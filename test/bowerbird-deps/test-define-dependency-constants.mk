test-define-one-dependency-entry:
	$(MAKE) def-one-dependency-entry

.PHONY: def-one-dependency-entry
def-one-dependency-entry:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	$(call bowerbird::test::compare-strings,$(ID.MK),$(abspath path/entry))


test-define-one-dependency-path:
	$(MAKE) def-one-dependency-path

.PHONY: def-one-dependency-path
def-one-dependency-path:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	$(call bowerbird::test::compare-strings,$(ID/PATH),$(abspath path))


test-define-one-dependency-url:
	$(MAKE) def-one-dependency-url

.PHONY: def-one-dependency-url
def-one-dependency-url:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	$(call bowerbird::test::compare-strings,$(ID/URL),url)


test-define-one-dependency-version:
	$(MAKE) def-one-dependency-version

.PHONY: def-one-dependency-version
def-one-dependency-version:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry))
	$(call bowerbird::test::compare-strings,$(ID/VERSION),version)


test-define-second-dependency-conflicting-entry:
	! $(MAKE) def-second-dependency-conflicting-entry

.PHONY: def-second-dependency-conflicting-entry
def-second-dependency-conflicting-entry:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry/alpha))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,version,path,entry/beta))


test-define-second-dependency-conflicting-path:
	! $(MAKE) def-second-dependency-conflicting-path

.PHONY: def-second-dependency-conflicting-path
def-second-dependency-conflicting-path:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path/alpha,path,version,entry))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path/beta,path,version,entry))


test-define-second-dependency-conflicting-url:
	! $(MAKE) def-second-dependency-conflicting-url

.PHONY: def-second-dependency-conflicting-url
def-second-dependency-conflicting-url:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/alpha,path,version,entry))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url/beta,path,version,entry))


test-define-second-dependency-conflicting-version:
	! $(MAKE) def-second-dependency-conflicting-version

.PHONY: def-second-dependency-conflicting-version
def-second-dependency-conflicting-version:
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path,path,version/alpha,entry))
	$(eval $(call bowerbird::deps::define-dependency-constants,ID,url,path,path,version/beta,entry))
