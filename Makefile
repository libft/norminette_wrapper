EXPECTED_NORMINETTE_VERSION := norminette 3.3.51
NORMINETTE ?= norminette

NORMINETTE_VERSION := 3.3.51
ifneq ($(shell $(NORMINETTE) --version), $(EXPECTED_NORMINETTE_VERSION))
$(error norminette version mismatch)
endif

NAME := norminette

.PHONY: all clean fclean re test
all: $(NAME)
test:
	@$(MAKE) -C test
clean:
	@rm -f $(NAME).tmp
fclean: clean
	@rm -f $(NAME)
re:
	@$(MAKE) fclean
	@$(MAKE) all

$(NAME):
	@cp src/$(NORMINETTE_VERSION).sh $(NAME).tmp
	@chmod a+x $(NAME).tmp
	@mv $(NAME).tmp $(NAME)
