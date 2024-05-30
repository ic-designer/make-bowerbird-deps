# Targets
PHONY: test-create-dep-variable
test-create-dep-variable: \
		test-create-variable-one-variable \
		test-create-variable-one-variable-conflicting-value \
		test-create-variable-one-variable-repeated-value \
		test-create-variable-two-variables \
		test-create-variable-two-variables-both-repeated-value \
		test-create-variable-two-variables-one-conflicting-value \

.PHONY: test-create-variable-one-variable
test-create-variable-one-variable:
	$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	@test $(ALPHA) = alpha
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"


.PHONY: test-create-variable-one-variable-conflicting-value
test-create-variable-one-variable-conflicting-value:
	@! $(MAKE) create-variable-one-variable-conflicting-value 2>/dev/null
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY: create-variable-one-variable-conflicting-value
create-variable-one-variable-conflicting-value:
	@$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	@$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,beta))


.PHONY: test-create-variable-one-variable-repeated-value
test-create-variable-one-variable-repeated-value:
	@$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	@$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	@test $(ALPHA) = alpha
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"


.PHONY: test-create-variable-two-variables
test-create-variable-two-variables:
	$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	$(eval $(call bowerbird::deps::__create-dep-variable,BETA,beta))
	@test $(ALPHA) = alpha
	@test $(BETA) = beta
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY: test-create-variable-two-variables-both-repeated-value
test-create-variable-two-variables-both-repeated-value:
	$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	$(eval $(call bowerbird::deps::__create-dep-variable,BETA,beta))
	$(eval $(call bowerbird::deps::__create-dep-variable,BETA,beta))
	@test $(ALPHA) = alpha
	@test $(BETA) = beta
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY: test-create-variable-two-variables-one-conflicting-value
test-create-variable-two-variables-one-conflicting-value:
	@!  $(MAKE) create-variable-two-variables-one-conflicting-value 2>/dev/null
	@test $(ALPHA) = alpha
	@test $(BETA) = beta
	@printf "\e[1;32mPassed: $(lastword $(MAKEFILE_LIST))::$@\e[0m\n"

.PHONY: create-variable-two-variables-one-conflicting-value
create-variable-two-variables-one-conflicting-value:
	$(eval $(call bowerbird::deps::__create-dep-variable,ALPHA,alpha))
	$(eval $(call bowerbird::deps::__create-dep-variable,BETA,beta))
	$(eval $(call bowerbird::deps::__create-dep-variable,BETA,gamma))
