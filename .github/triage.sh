#!/usr/bin/env bash
#
# Maintainer triage helper for Awesome Creator Tools.
#
# Prints facts. It makes no decisions and posts nothing. The judgement calls
# still need a person: whether a free tier genuinely exists, whether a link
# points at the real project or a reseller wrapping someone else's model, and
# whether the tool belongs on this list at all.
#
# Requires gh (authenticated) and curl.

set -uo pipefail

UA='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'

usage() {
  cat <<'EOF'
Usage: .github/triage.sh <command>

  prs      facts for every open pull request
  health   archived and stale projects already on the list
EOF
}

# slug -> "stars<TAB>created<TAB>pushed<TAB>archived"
repo_facts() {
  gh api "repos/$1" \
    --jq '"\(.stargazers_count)\t\(.created_at[:10])\t\(.pushed_at[:10])\t\(.archived)"' \
    2>/dev/null || printf -- '-\t-\t-\t-'
}

cmd_prs() {
  printf '%-6s %-5s %-7s %-11s %-11s %-5s %s\n' PR HTTP STARS CREATED PUSHED DISC LINK
  for n in $(gh pr list --state open --json number --jq '.[].number'); do
    url=$(gh pr diff "$n" 2>/dev/null | grep '^+' \
          | grep -oE '\]\(https?://[^)]+\)' | head -1 | sed 's/^](//;s/)$//')
    [ -n "$url" ] || url='(no link in diff)'

    code=$(curl -sSL -o /dev/null -w '%{http_code}' --max-time 20 -A "$UA" "$url" 2>/dev/null)
    [ -n "$code" ] || code='ERR'

    slug=$(printf '%s' "$url" | sed -nE 's#^https://github\.com/([^/]+/[^/?#]+).*#\1#p')
    stars='-'; created='-'; pushed='-'; archived='-'
    if [ -n "$slug" ]; then
      IFS=$'\t' read -r stars created pushed archived <<<"$(repo_facts "$slug")"
      [ "$archived" = 'true' ] && pushed='ARCHIVED'
    fi

    if gh pr view "$n" --json body --jq '.body' 2>/dev/null \
       | grep -qiE 'disclos|affiliat|i am the (maker|author|founder|creator)|i (built|made|created) (this|it)'; then
      disc='yes'
    else
      disc='no'
    fi

    printf '%-6s %-5s %-7s %-11s %-11s %-5s %s\n' \
      "#$n" "$code" "$stars" "$created" "$pushed" "$disc" "${url:0:58}"
  done

  cat <<'EOF'

How to read this. A repository created within days of its pull request, or
sitting at a handful of stars, has no independent usage behind it yet. Any
HTTP code other than 200 is worth opening, though 401, 403 and 429 usually
mean bot protection rather than a dead link. DISC is a crude grep for an
affiliation disclosure, so treat a "no" as a prompt to read the PR, not proof.
EOF
}

cmd_health() {
  printf '%-11s %-9s %-7s %s\n' PUSHED ARCHIVED STARS PROJECT
  grep -oE 'https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' README.md \
    | sed 's|https://github.com/||' | sort -u \
    | while read -r slug; do
        IFS=$'\t' read -r stars _created pushed archived <<<"$(repo_facts "$slug")"
        printf '%-11s %-9s %-7s %s\n' "$pushed" "$archived" "$stars" "$slug"
      done | sort

  cat <<'EOF'

Oldest first. Archived projects should come off the list, since CONTRIBUTING
rules them out. A long gap since the last push is a prompt to check whether a
maintained alternative has taken over, not an automatic removal.
EOF
}

case "${1:-}" in
  prs)    cmd_prs ;;
  health) cmd_health ;;
  *)      usage; exit 1 ;;
esac
