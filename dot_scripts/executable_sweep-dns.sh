#!/usr/bin/env bash

# Usage check
if [[ -z "$1" ]]; then
  echo "Usage: $0 <domain>"
  echo "Example: $0 example.com"
  exit 1
fi

domain="$1"

types=(A AAAA MX TXT CNAME NS SOA SRV CAA)
names=(
  ""
  www
  mail
  smtp
  web
  api
  vpn
  autodiscover
  autoconfig
  _dmarc
  _domainkey
  selector1._domainkey
  selector2._domainkey
)

echo "DNS sweep for: $domain"
echo "========================================"

for n in "${names[@]}"; do
  fqdn="${n:+$n.}$domain"
  echo -e "\n===== ${n:-apex} ($fqdn) ====="

  for t in "${types[@]}"; do
    result=$(dig "$fqdn" "$t" +noall +answer)
    [[ -n "$result" ]] && echo "$result"
  done
done
