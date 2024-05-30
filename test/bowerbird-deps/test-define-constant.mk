# Targets
PHONY: test-define-constant
test-define-constant: \
		test-define-one-constant \
		test-define-one-constant-conflicting-value \
		test-define-one-constant-repeated-value \
		test-define-two-constants \
		test-define-two-constants-conflicting-value \
		test-define-two-constants-repeated-value \

.PHONY: test-define-one-constant
test-define-one-constant:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	@test $(ALPHA) = alpha
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"


.PHONY: test-define-one-constant-conflicting-value
test-define-one-constant-conflicting-value:
	@! $(MAKE) define-one-constant-conflicting-value 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY: define-one-constant-conflicting-value
define-one-constant-conflicting-value:
	@$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	@$(eval $(call bowerbird::deps::define-constant,ALPHA,beta))


.PHONY: test-define-one-constant-repeated-value
test-define-one-constant-repeated-value:
	@$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	@$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	@test $(ALPHA) = alpha
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"


.PHONY: test-define-two-constants
test-define-two-constants:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	@test $(ALPHA) = alpha
	@test $(BETA) = beta
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"


.PHONY: test-define-two-constants-conflicting-value
test-define-two-constants-conflicting-value:
	@!  $(MAKE) define-two-constants-conflicting-value 2>/dev/null
	@test $(ALPHA) = alpha
	@test $(BETA) = beta
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY: define-two-constants-conflicting-value
define-two-constants-conflicting-value:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	$(eval $(call bowerbird::deps::define-constant,BETA,gamma))


.PHONY: test-define-two-constants-repeated-value
test-define-two-constants-repeated-value:
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,ALPHA,alpha))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	$(eval $(call bowerbird::deps::define-constant,BETA,beta))
	@test $(ALPHA) = alpha
	@test $(BETA) = beta
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"
