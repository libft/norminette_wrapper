EXPECTED_NORMINETTE_VERSION := norminette 3.3.51
NORMINETTE ?= norminette

NORMINETTE_VERSION := 3.3.51
ifneq ($(shell $(NORMINETTE) --version), $(EXPECTED_NORMINETTE_VERSION))
$(error norminette version mismatch)
endif

.PHONY: test
test:
	@(cd $(NORMINETTE_VERSION) && sh test.sh)
