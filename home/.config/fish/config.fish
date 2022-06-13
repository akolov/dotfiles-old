# Functions

function fish_user_key_bindings
  bind \cr percol_select_history
  bind \e\b backward-kill-word
  bind \cx\x7f backward-kill-line
end

function nuke_derived_data
  set -l derived_path "$HOME/Library/Developer/Xcode/DerivedData"
  rm -rf "$derived_path"
  if test $status = 0
    echo "Deleted $derived_path"
  else
    echo "Failed to delete $derived_path"
  end
end

### Configuration

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

fish_add_path /usr/local/opt/python/libexec/bin
fish_add_path /usr/local/var/rbenv/shims
fish_add_path /usr/local/sbin
fish_add_path ~/.bin
fish_add_path /usr/libexec
fish_add_path ~/.fastlane/bin
fish_add_path ~/Library/Application\ Support/multipass/bin

if set nvim_path (which nvim)
  set -gx EDITOR $nvim_path
end

set -gx HOMEBREW_GITHUB_API_TOKEN (cat ~/.github_token)
set -gx Z_SCRIPT_PATH  (brew --prefix)/etc/profile.d/z.sh
set -gx OMF_PATH "/Users/alex/.local/share/omf"

alias grep "grep --color=auto"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

export RUBY_CONFIGURE_OPTS=--with-openssl-dir=(brew --prefix openssl@1.1)

export SSL_CERT_FILE=/Users/alex/.proxyman/proxyman-ca.pem
export REQUESTS_CA_BUNDLE=/Users/alex/.proxyman/proxyman-ca.pem

# Platform-dependent settings
switch (uname)
  case Darwin
    alias fixfinder "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
    alias flushdns "sudo discoveryutil mdnsflushcache; and sudo discoveryutil udnsflushcaches; and echo done"
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
