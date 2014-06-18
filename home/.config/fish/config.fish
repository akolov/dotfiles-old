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

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins brew jump python rbenv

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

alias grep "grep --color=auto"

# Platform-dependent settings
switch (uname)
  case Darwin
    set -x EDITOR /usr/local/bin/atom
    set -x RBENV_ROOT /usr/local/var/rbenv
    set -x HOMEBREW_GITHUB_API_TOKEN 10c9169ca19cc48f77729ce1edb706e639d496eb

    alias fixfinder "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
    alias swift "xcrun swift"
    alias swift "xcrun swift"
    alias flushdns "sudo dscacheutil -flushcache"
    alias gh "open (git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//')"
end