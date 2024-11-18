# plugins=(git)

export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
export DISABLE_UPDATE_PROMPT=true
export GOPATH="/Users/sean/go"
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export PIP_REQUIRE_VIRTUALENV=true
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYTHONBREAKPOINT=ipdb.set_trace
export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH="$PYENV_ROOT:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/Users/sean/.cargo/bin:$PATH"
export PATH="/Users/sean/.local/bin:$PATH"
export PATH="/Users/sean/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

source $HOME/.atuin/bin/env
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

source ~/.zshenv

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init -)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/vault vault
source <(kubectl completion zsh)

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh --disable-up-arrow)"
