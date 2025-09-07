#.scripts/install-packages.sh
#!/usr/bin/env bash

set -euo pipefail


SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"


ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook "$SCRIPT_DIR/playbooks/install_common_packages.yml" -K 

ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook "$SCRIPT_DIR/playbooks/install_common_packages.yml" -K -v

ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook "$SCRIPT_DIR/playbooks/install_common_packages.yml" -K -vv

ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook "$SCRIPT_DIR/playbooks/install_common_packages.yml" -K -vvv
