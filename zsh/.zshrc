# plugins=(git)

export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
export DISABLE_UPDATE_PROMPT=true
export F_BASE="$HOME/code/github/wt"
export GODOT="/Applications/Godot_mono.app/Contents/MacOS/Godot"
export GOPATH="/Users/sean/go"
export KUBE_EDITOR=nvim
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export MANPAGER='nvim +Man!'
export PIP_REQUIRE_VIRTUALENV=true
export PYTHONBREAKPOINT=ipdb.set_trace
export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/Users/sean/.cargo/bin:$PATH"
export PATH="/Users/sean/.local/bin:$PATH"
export PATH="/Users/sean/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# .zprofile already ran this for login shells.
[[ -z $HOMEBREW_PREFIX ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# oh-my-zsh runs compinit, so only extend FPATH here.
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

# Source a tool's generated init script, regenerating it only when the binary changes.
_cached_eval() {
  local cache=~/.cache/zsh/${(j:-:)${@//[^a-zA-Z0-9]/}}.zsh
  if [[ ! -s $cache || $commands[$1] -nt $cache ]]; then
    mkdir -p ${cache:h} && "$@" >| $cache
  fi
  source $cache
}

source $HOME/.atuin/bin/env
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

_cached_eval starship init zsh --print-full-init

if [[ "$CLAUDECODE" != "1" ]]; then
    _cached_eval zoxide init --cmd cd zsh
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/vault vault
_cached_eval kubectl completion zsh

_cached_eval atuin init zsh --disable-up-arrow

# pnpm
export PNPM_HOME="/Users/sean/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
