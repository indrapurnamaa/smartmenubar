#!/bin/zsh
set -eu

# Keep Chrome as the default for compatibility with existing commands.
case "${2:-chrome}" in
  chrome) app_name=Chrome; app_domain=com.google.Chrome ;;
  safari) app_name=Safari; app_domain=com.apple.Safari ;;
  brave) app_name=Brave; app_domain=com.brave.Browser ;;
  pcsx2) app_name=PCSX2; app_domain=net.pcsx2.pcsx2 ;;
  *) print -u2 'App must be chrome, safari, brave, or pcsx2'; exit 2 ;;
esac
case "${1:-status}" in
  status)
    /usr/bin/defaults read "$app_domain" AppleMenuBarVisibleInFullscreen 2>/dev/null || {
      print "$app_name has no override; it follows the system setting."
    }
    ;;
  enable)
    /usr/bin/defaults write "$app_domain" AppleMenuBarVisibleInFullscreen -bool false
    print "Override enabled. Quit $app_name with Cmd+Q and reopen it to test."
    ;;
  restore)
    # Remove the override so the app follows the system setting.
    if /usr/bin/defaults read "$app_domain" AppleMenuBarVisibleInFullscreen >/dev/null 2>&1; then
      /usr/bin/defaults delete "$app_domain" AppleMenuBarVisibleInFullscreen
    fi
    print "$app_name now follows the system setting. Quit and reopen $app_name."
    ;;
  *)
    print -u2 'Usage: zsh menubar.sh [status|enable|restore] [chrome|safari|brave|pcsx2]'
    exit 2
    ;;
esac
