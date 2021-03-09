# Makefile for majortomo

SHELL := bash

PIP := pip
PIP_SYNC := pip-sync
PIP_COMPILE := pip-compile
PYTHON := python
PYTEST := pytest
GIT := git

DIST_DIR = dist

PYTHON_VERSION := $(shell $(PYTHON) -c 'import sys; print(sys.version.split(" ")[0])')
VERSION_FILE := VERSION
PACKAGE_VERSION := $(shell cat $(VERSION_FILE))
VERSION_TAG_PREFIX = ""
VERSION_TAG_SUFFIX = ""
VERSION_TAG := "$(VERSION_TAG_PREFIX)$(PACKAGE_VERSION)$(VERSION_TAG_SUFFIX)"


requirements.txt: requirements.in
	$(PIP_COMPILE) --no-emit-index-url --output-file $@ $<

dev-requirements.txt: dev-requirements.in
	$(PIP_COMPILE) --no-emit-index-url --output-file $@ $<

.install-dev-requirements-%: requirements.txt dev-requirements.txt
	$(PIP_SYNC) requirements.txt dev-requirements.txt
	$(PIP) freeze > $@

prepare-test: .install-dev-requirements-$(PYTHON_VERSION)
	$(PIP) install -e .
.PHONY: prepare-test

test: prepare-test
	$(PYTEST) --flake8 --isort --mypy majortomo tests
.PHONY: test

requirements: requirements.txt dev-requirements.txt
.PHONY: requirements

dist:
	$(PIP) install -U pip wheel twine
	$(PYTHON) setup.py bdist_wheel sdist -d $(DIST_DIR)
.PHONY: dist

distclean:
	rm -rf $(DIST_DIR)
.PHONY: distclean

tag-version:
	$(GIT) tag $(VERSION_TAG)
	$(GIT) push --tags

release: distclean dist
	@echo "--------------------------------------------------------------------------------"
	@echo "You are about to create git tag $(VERSION_TAG) and upload a new package to pypi."
	@echo "Hit Enter to continue or Ctrl+C to stop"
	@echo "--------------------------------------------------------------------------------"
	@read
	$(MAKE) tag-version
	twine upload $(DIST_DIR)/*
