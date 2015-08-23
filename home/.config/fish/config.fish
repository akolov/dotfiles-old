# Helper functions

function path_prepend --description "Insert existing directories to the begining of PATH"
   for i in $argv
      if test -d $i
          set -x PATH $i $PATH
      end
   end
end

function path_append --description "Append existing directories the the end of PATH"
    for i in $argv
        if test -d $i
            set -x PATH $PATH $i
        end
    end
end

# Configuration

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

path_prepend /usr/local/sbin
path_prepend ~/.bin
path_append /usr/libexec

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Platform-dependent settings
switch (uname)
  case Darwin
    set -x EDITOR /usr/local/bin/atom
    set -x RBENV_ROOT /usr/local/var/rbenv
    set -x HOMEBREW_GITHUB_API_TOKEN (cat ~/.github_token)

    alias fixfinder "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
    alias flushdns "sudo discoveryutil mdnsflushcache; and sudo discoveryutil udnsflushcaches; and echo done"
    alias bootcamp "sudo bless -mount /Volumes/BOOTCAMP --setBoot --nextonly; and sudo shutdown -r now"
end

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

Theme "robbyrussell"
Plugin "brew"
Plugin "jump"
Plugin "python"
Plugin "rbenv"
Plugin "mc"
Plugin "percol"

alias grep "grep --color=auto"

function fish_user_key_bindings
  bind \cr percol_select_history
end

function proj
  cd "$HOME/Projects/$argv"
end

function update_xcode_plugins
  set -lx xcode_paths /Applications/Xcode.app /Applications/Xcode-beta.app
  for i in $xcode_paths
    if test -d $i
      set -lx uuid (defaults read $i/Contents/Info DVTPlugInCompatibilityUUID)
      for f in (find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name 'Info.plist')
        if not grep -qs $uuid $f
          PlistBuddy -c "Add :DVTPlugInCompatibilityUUIDs: string $uuid" $f
        end
      end
    end
  end
end

function nuke_derived_data
  set -l derived_path "~/Library/Developer/Xcode/DerivedData"
  rm -rf $derived_path
  if test $status = 0
    echo "Deleted $derived_path"
  else
    echo "Failed to delete $derived_path"
  end
end
