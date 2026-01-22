#
# Ansible Boilerplate Collection: Makefile for the project itself.
#

DIST_D = $(CURDIR)/dist

# Include the "real" boilerplate Makefile into this "wrapper" Makefile:
include Makefile.boilerplate

check: check-ansible
	@if command -v mdl >/dev/null; then \
	    make check-mdl; \
	 else \
	    printf '\e[1;33mWarning:\e[0m "mdl" not found, skipping Markdown tests!\n'; \
	 fi
	@if command -v shellcheck >/dev/null; then \
	    make check-shellcheck; \
	 else \
	    printf '\e[1;33mWarning:\e[0m "shellcheck" not found, skipping shell script tests!\n'; \
	 fi
	@printf "\n\e[32;1mChecks completed successfully.\e[0m\n\n"

check-mdl:
	mdl -g -s .mdl-rules.rb -w .

check-shellcheck:
	shellcheck \
	 bin/abc \
	 bin/a bin/ap bin/aps \
	 libexec/abc*

distclean:
#	Remove distribution directory
	rm -fr "$(DIST_D)"

dist: all $(VENV_BIN)/ansible-galaxy
#	Create distribution archive ...
	mkdir -p "$(DIST_D)"
	"$(VENV_BIN)"/ansible-galaxy collection build --force --output-path "$(DIST_D)"

distcheck: dist
#	Run tests on distribution archive ...
	mkdir -p "$(DIST_D)/check"
	tar -C "$(DIST_D)/check" -xzf $$(find "$(DIST_D)" -name '*.tar.gz' | sort -Vr | head -n1)
	test -e "$(VENV_D)" && ln -fs "$(VENV_D)" "$(DIST_D)/check/.venv"
	make -C "$(DIST_D)/check" check
#	Clean up ...
	rm -fr "$(DIST_D)/check"

.PHONY: check check-mdl check-shellcheck
.PHONY: distclean dist distcheck
