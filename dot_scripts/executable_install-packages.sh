#.scripts/install-packages.sh
#!/usr/bin/env bash
set -euo pipefail

# Resolve script dir
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Hide "skipped" noise
export ANSIBLE_DISPLAY_SKIPPED_HOSTS=false

# Add -K (ask become pass) unless the user already provided it
add_become="-K"
for arg in "$@"; do
  if [[ "$arg" == "-K" || "$arg" == "--ask-become-pass" ]]; then
    add_become=""
    break
  fi
done

# Pass all user flags (e.g., -v/-vv/-vvv) straight through
exec ansible-playbook "$SCRIPT_DIR/playbooks/install_common_packages.yml" $add_become "$@"
