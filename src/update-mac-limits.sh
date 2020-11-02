#! /usr/bin/env bash

# Instructions copied from https://wilsonmar.github.io/maximum-limits/

THIS_DIR="$(cd "$(dirname "$BASH_SOURCE")" && pwd)"
ROOT_DIR="$(cd "$(dirname "$THIS_DIR")" && pwd)"

main() {
  sudo cp "$ROOT_DIR/templates/limit.maxfiles.plist" /Library/LaunchDaemons/limit.maxfiles.plist
  sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
  sudo chmod 644 /Library/LaunchDaemons/limit.maxfiles.plist
  sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
