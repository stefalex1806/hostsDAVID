#!/bin/bash
cat /etc/hosts | while read ip name rest; do
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] && [[ -n "$name" ]]; then
        ip_nslookup=$(nslookup "$name" 2>/dev/null | grep -A 1 'Name:' | grep 'Address:' | awk '{print $2}' | tail -n 1)
        if [[ -n "$ip_nslookup" ]] && [[ "$ip" != "$ip_nslookup" ]]; then
            echo "Bogus IP for $name in /etc/hosts! Config: $ip, Resolved: $ip_nslookup"
        fi
    fi
done
echo "ALEX"
