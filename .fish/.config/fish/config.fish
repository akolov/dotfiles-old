# helper functions

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

function git-create-tag
    git tag -a -m $argv
    git push --tags
end

function git-delete-tag
    git tag -d $argv
    git push origin :refs/tags/$argv
end

# configuration

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x EDITOR /usr/local/bin/mate
#set -x PYTHONPATH /usr/local
set -x RBENV_ROOT /usr/local/var/rbenv
set -x HOMEBREW_GITHUB_API_TOKEN 10c9169ca19cc48f77729ce1edb706e639d496eb

# insert homebrew's bin and sbin to the beginig of PATH
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
alias fixfinder "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
alias swift "xcrun swift"
