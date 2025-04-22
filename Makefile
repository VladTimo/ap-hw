# Makefile to run ansible for both compA and compB

ANSIBLE := $(shell which ansible-playbook)
ANSIBLE_DIR := infra/ansible
REQUIREMENTS_FILE := $(ANSIBLE_DIR)/requirements.yml
ROLES_DIR := $(ANSIBLE_DIR)/roles
INVENTORY := $(ANSIBLE_DIR)/inventory.ini
COMPA_PLAYBOOK := $(ANSIBLE_DIR)/compa.yml
COMPB_PLAYBOOK := $(ANSIBLE_DIR)/compb.yml

.PHONY: all check-ansible install-roles compa compb

all: check-ansible install-roles compa compb

check-ansible:
	@echo "Checking if ansible installed"
	@if [ -z "$(ANSIBLE)" ]; then \
		echo "Ansible is not installed. Install it before running playbooks."; \
		exit 1; \
	else \
		echo "Ansible found at $(ANSIBLE)"; \
	fi

install-roles:
	@echo "Checking that roles from requirements installed in /roles folder"
	@if [ ! -f "$(ROLES_DIR)/.galaxy_install.lock" ]; then \
		if [ -f "$(REQUIREMENTS_FILE)" ]; then \
			ansible-galaxy install -r $(REQUIREMENTS_FILE) -p $(ROLES_DIR); \
			touch $(ROLES_DIR)/.galaxy_install.lock; \
			echo "Roles installed."; \
		else \
			echo "$(REQUIREMENTS_FILE) not found! Skipping role installation."; \
		fi \
	else \
		echo "Roles already installed."; \
	fi

compa:
	@echo "Running compa playbook..."
	$(ANSIBLE) -i $(INVENTORY) $(COMPA_PLAYBOOK)

compb: compa
	@echo "Running compb playbook (after compa)..."
	$(ANSIBLE) -i $(INVENTORY) $(COMPB_PLAYBOOK)
