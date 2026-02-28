#!/usr/bin/env bash
set -euo pipefail

# ip-sweep.sh — quick IP intel for triage
#
# Usage:
#   ./ip-sweep.sh <ip>
#   ./ip-sweep.sh <ip> --nmap
#
# Examples:
#   ./ip-sweep.sh 44.203.112.2
#   ./ip-sweep.sh 44.203.112.2 --nmap

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <ip> [--nmap]"
  echo "Example: $0 44.203.112.2"
  exit 1
fi

ip="$1"
do_nmap="false"
if [[ "${2:-}" == "--nmap" ]]; then
  do_nmap="true"
fi

have() { command -v "$1" >/dev/null 2>&1; }

section() {
  echo
  echo "===== $1 ====="
}

echo "IP sweep for: $ip"
echo "========================================"

# ---- Reverse DNS ----
section "Reverse DNS (PTR)"
if have dig; then
  ptr="$(dig -x "$ip" +short | sed 's/\.$//' || true)"
  if [[ -n "${ptr:-}" ]]; then
    echo "PTR: $ptr"
  else
    echo "PTR: (none)"
  fi
else
  echo "dig not found (install: sudo apt install dnsutils)"
fi

# ---- Team Cymru (ASN/BGP) ----
section "ASN / BGP"
if have whois; then
  # -v gives: ASN | IP | BGP Prefix | CC | Registry | Allocated | AS Name
  cymru="$(whois -h whois.cymru.com " -v $ip" 2>/dev/null || true)"
  if [[ -n "${cymru:-}" ]]; then
    echo "$cymru"
  else
    echo "No Cymru response (blocked network or whois failure)."
  fi
else
  echo "whois not found (install: sudo apt install whois)"
fi

# ---- WHOIS summary ----
section "WHOIS (registrant / abuse / netrange)"
if have whois; then
  # Different RIRs label fields differently; this grabs common ones.
  whois_out="$(whois "$ip" 2>/dev/null || true)"
  if [[ -n "${whois_out:-}" ]]; then
    echo "$whois_out" | awk '
      BEGIN{IGNORECASE=1}
      /OrgName:|Organization:|org-name:|descr:|netname:|NetName:|NetRange:|inetnum:|CIDR:|country:|Country:|OriginAS:|origin:|abuse-mailbox:|OrgAbuseEmail:|AbuseEmail:|abuse@|e-mail:|Email:|mnt-by:|created:|changed:/ {
        print
      }
    ' | sed 's/[[:space:]]\+$//' | head -n 80
  else
    echo "WHOIS returned no output."
  fi
else
  echo "whois not found (install: sudo apt install whois)"
fi

# ---- ipinfo.io (quick enrichment) ----
section "Enrichment (ipinfo.io)"
if have curl; then
  # Note: ipinfo may rate-limit; still useful for quick checks.
  curl -fsS "https://ipinfo.io/${ip}/json" 2>/dev/null || echo "ipinfo.io lookup failed (rate limit / no internet)."
else
  echo "curl not found (install: sudo apt install curl)"
fi


# ---- TLS peek (optional) ----
section "TLS certificate peek (if 443 reachable)"
if have openssl; then
  # Quick attempt; won't hang forever.
  cert_subject="$(echo | timeout 4 openssl s_client -connect "${ip}:443" -servername "${ip}" 2>/dev/null \
    | openssl x509 -noout -subject -issuer 2>/dev/null || true)"
  if [[ -n "${cert_subject:-}" ]]; then
    echo "$cert_subject"
  else
    echo "No cert info (port closed, filtered, or non-TLS)."
  fi
else
  echo "openssl not found (install: sudo apt install openssl)"
fi


echo
echo "Done."
