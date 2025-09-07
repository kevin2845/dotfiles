#!/usr/bin/env bash
set -euo pipefail

# Resolve script dir (so it runs from anywhere)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Tidy Ansible output
export ANSIBLE_DISPLAY_SKIPPED_HOSTS=false

# Build args: add -K unless user supplied it
args=("$@")
need_become=true
for a in "$@"; do
  if [[ "$a" == "-K" || "$a" == "--ask-become-pass" ]]; then
    need_become=false
    break
  fi
done
if $need_become; then
  args=(-K "${args[@]}")
fi

run_pb() {
  local playbook="$1"; shift
  ansible-playbook "$SCRIPT_DIR/playbooks/$playbook" "$@"
}

# 1) UPDATE
set +e
run_pb update_packages.yml "${args[@]}"
rc_update=$?
set -e

if (( rc_update != 0 )); then
  echo "⚠️  Update playbook exited with code ${rc_update}."
fi

# 2) PROMPT, then UPGRADE
read -rp "Upgrade packages to latest now? [y/N] " ans
case "${ans:-N}" in
  y|Y|yes|YES)
    set +e
    run_pb upgrade_packages.yml "${args[@]}"
    rc_upgrade=$?
    set -e
    exit "${rc_upgrade}"
    ;;
  *)
    echo "Skipping upgrade."
    exit "${rc_update}"
    ;;
esac
