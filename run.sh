#!/usr/bin/env bash
set -Eeuo pipefail

sudo apt --update install -y \
  git \
  ca-certificates \
  python3 \
  python3-pip \
  python3-venv

python3 -m venv .venv

if [[ ! -d .venv/bin ]]; then
  echo "virtualenv missing (.venv/bin not found)" >&2
  exit 1
fi

source .venv/bin/activate

python -m pip install --upgrade pip
pip install -r ./ansible/requirements.txt

ANSIBLE_CONFIG=./ansible/ansible.cfg ansible-playbook \
  -i ./ansible/inventory ./ansible/site.yml --ask-become-pass "$@"
