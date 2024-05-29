#
# Ansible Boilerplate Collection: Makefile for the project itself.
#

DIST_D = $(CURDIR)/dist

default: all

# Include the "real" boilerplate Makefile into this "wrapper" Makefile:
include Makefile.boilerplate

check: check-ansible
	if command -v mdl >/dev/null; then make check-mdl; fi
	if command -v shellcheck >/dev/null; then make check-shellcheck; fi

check-mdl:
	mdl -g -r '~MD013,~MD029' -w .

check-shellcheck:
	shellcheck \
	 bin/ansible-boilerplate \
	 bin/a bin/ap bin/aps

install:

clean:

distclean: clean distclean-ansible
#	Remove distribution directory
	rm -fr "$(DIST_D)"

maintainer-clean: distclean

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

.PHONY: default all check install clean distclean maintainer-clean dist distcheck
