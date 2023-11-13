# Set up the prompt requires nerd font
PS1="%F{red} %n%f  %B%F{white}%3~%F{white} : %b%f%k"


# Custom Functions
cmd_function() { # Cmd function add seemless integration of cmd functionality to wsl
    # Requires to run sudo update-binfmts --disable cli first, it's automatically running in .bashrc before launching zsh
    local wsl_path=$PWD
    local win_path=$(echo $wsl_path | sed 's|/mnt/\(.\)/|\1:/|' | tr '/' '\\')
    cmd.exe /k " pushd \\\\wsl.localhost\\Ubuntu & cd $win_path & $* & exit" 2> NUL
    rm NUL # since it starts the shell from the current dirrectory which is UNC it gives an error everytime which can be annoying
  }

  cbuild_function(){ # Compiles c code into a linux executable and windows executable
    x86_64-w64-mingw32-gcc -o $*.exe *.c && gcc *.c -o $*
    chmod +x $*
  }
  cppbuild_function(){ # Compiles c++ code into a linux executable and windows executable
    x86_64-w64-mingw32-g++ -o $*.exe *.cpp && g++ *.cpp -o $*
    chmod +x $*
  }

# Aliases
alias cmd='cmd_function'
alias win11='cd /mnt/c/Users/jacob'
alias cbuild='cbuild_function'
alias cppbuild='cppbuild_function'
alias cmd='cmd_function'
alias ls="lsd -1"
alias cat="batcat -P"

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export LIBGL_ALWAYS_INDIRECT=1
