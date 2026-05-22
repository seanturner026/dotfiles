gfco() {
  git fetch origin "$1" && git checkout "$1"
}

# jira-new — create a Jira ticket: title as arg, clipboard as description,
# assigned to you, then fzf-pick a status to transition to.
#   usage: jira-new "ticket title"
#   env:   JIRA_NEW_PROJECT (default RE), JIRA_NEW_TYPE (default Task)
jira-new() {
  local title="$*"
  if [[ -z "$title" ]]; then
    echo "usage: jira-new <title>  (description is read from clipboard)" >&2
    return 2
  fi

  local project="${JIRA_NEW_PROJECT:-RE}"
  local type="${JIRA_NEW_TYPE:-Task}"
  local me body out key state
  me="$(jira me)" || return $?
  body="$(pbpaste)"

  out="$(jira issue create \
    -p "$project" \
    -t "$type" \
    -s "$title" \
    -a "$me" \
    -b "$body" \
    --no-input 2>&1)"
  local rc=$?
  printf '%s\n' "$out"
  [[ $rc -ne 0 ]] && return $rc

  key="$(printf '%s\n' "$out" | grep -oE "${project}-[0-9]+" | head -n1)"
  if [[ -z "$key" ]]; then
    echo "jira-new: couldn't parse issue key from output" >&2
    return 1
  fi

  state="$(printf 'Backlog\nTo Do\nIn Progress\n(skip)\n' \
    | fzf --prompt="move ${key} to: " --height=8 --layout=reverse --no-info)"
  [[ -z "$state" || "$state" == "(skip)" ]] && return 0

  jira issue move "$key" "$state"
}
