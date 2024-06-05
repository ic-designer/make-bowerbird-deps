test-define-one-constant:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(call bowerbird::test::compare-string,$(ALPHA),alpha)


test-define-one-constant-conflicting-value:
	! $(MAKE) define-one-constant-conflicting-value

define-one-constant-conflicting-value:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,ALPHA,beta))


test-define-one-constant-repeated-value:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(call bowerbird::test::compare-string,$(ALPHA),alpha)


test-define-two-constants:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	$(call bowerbird::test::compare-string,$(ALPHA),alpha)
	$(call bowerbird::test::compare-string,$(BETA),beta)


test-define-two-constants-repeated-value:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	$(call bowerbird::test::compare-string,$(ALPHA),alpha)
	$(call bowerbird::test::compare-string,$(BETA),beta)
