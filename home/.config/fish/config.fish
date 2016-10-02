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

function fish_user_key_bindings
  bind \cr percol_select_history
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

path_prepend /usr/local/var/rbenv/shims
path_prepend /usr/local/sbin
path_prepend ~/.bin
path_append /usr/libexec

if set mc_path (which mcedit)
  set -gx EDITOR $mc_path
end

# Platform-dependent settings
switch (uname)
  case Darwin
    set -gx HOMEBREW_GITHUB_API_TOKEN (cat ~/.github_token)
    set -gx Z_SCRIPT_PATH  (brew --prefix)/etc/profile.d/z.sh

    alias fixfinder "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
    alias flushdns "sudo discoveryutil mdnsflushcache; and sudo discoveryutil udnsflushcaches; and echo done"
    alias bootcamp "sudo bless -mount /Volumes/BOOTCAMP --setBoot --nextonly; and sudo shutdown -r now"
end

alias grep "grep --color=auto"

# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/alex/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
