#!/bin/bash

echo "=== User Audit Report ==="

# 1️⃣ Count total users (from /etc/passwd)
TOTAL_USERS=$(wc -l < /etc/passwd)
echo "Total users: $TOTAL_USERS"

# 2️⃣ Users with valid shell access (not /nologin or /false)
SHELL_USERS=$(awk -F: '$7 !~ /(nologin|false)$/ {print $1}' /etc/passwd)
SHELL_USERS_COUNT=$(echo "$SHELL_USERS" | wc -l)
echo "Users with shell access: $SHELL_USERS_COUNT"

# 3️⃣ Users without passwords (empty password field in /etc/shadow)
NO_PASS_USERS=$(awk -F: '($2 == "" || $2 == "*") {print $1}' /etc/shadow 2>/dev/null)
NO_PASS_USERS_COUNT=$(echo "$NO_PASS_USERS" | wc -l)
echo "Users without password: $NO_PASS_USERS_COUNT"

# Print names if exists
if [ "$NO_PASS_USERS_COUNT" -gt 0 ]; then
  echo "$NO_PASS_USERS" | sed 's/^/  - /'
fi

# 4️⃣ Last login info (for shell users only)
echo "Last login info for shell users:"
for USER in $SHELL_USERS; do
  LAST_LOGIN=$(lastlog -u "$USER" | awk 'NR==2 {print $4, $5, $6}')
  echo "  - $USER: ${LAST_LOGIN:-Never}"
done
