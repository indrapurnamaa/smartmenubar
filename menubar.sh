#!/bin/zsh
set -eu

# Keep Chrome as the default for compatibility with existing commands.
case "${2:-chrome}" in
  chrome) browser_name=Chrome; browser_domain=com.google.Chrome ;;
  safari) browser_name=Safari; browser_domain=com.apple.Safari ;;
  brave) browser_name=Brave; browser_domain=com.brave.Browser ;;
  *) print -u2 'Browser must be chrome, safari, or brave'; exit 2 ;;
esac
case "${1:-status}" in
  status)
    /usr/bin/defaults read "$browser_domain" AppleMenuBarVisibleInFullscreen 2>/dev/null || {
      print "$browser_name has no override; it follows the system setting."
    }
    ;;
  enable)
    /usr/bin/defaults write "$browser_domain" AppleMenuBarVisibleInFullscreen -bool false
    print "Override enabled. Quit $browser_name with Cmd+Q and reopen it to test."
    ;;
  restore)
    # Before enabling, these browser keys were absent on this Mac.
    if /usr/bin/defaults read "$browser_domain" AppleMenuBarVisibleInFullscreen >/dev/null 2>&1; then
      /usr/bin/defaults delete "$browser_domain" AppleMenuBarVisibleInFullscreen
    fi
    print "$browser_name now follows the system setting. Quit and reopen $browser_name."
    ;;
  *)
    print -u2 'Usage: zsh chrome-menubar.sh [status|enable|restore] [chrome|safari|brave]'
    exit 2
    ;;
esac
