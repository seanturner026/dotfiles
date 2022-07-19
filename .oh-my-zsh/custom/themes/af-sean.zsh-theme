# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

# if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
# local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


# primary prompt
#PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
PROMPT=' $FG[032]%~\
$(git_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'
# RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# right prompt
#if type "virtualenv_prompt_info" > /dev/null
#then
#	RPROMPT='$(virtualenv_prompt_info)$my_gray%n@%m%{$reset_color%}%'
#else
#	RPROMPT='$my_gray%n@%m%{$reset_color%}%'
#fi

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# # kube-ps1
# source /opt/homebrew/Cellar/kube-ps1/0.7.0/share/kube-ps1.sh
# PROMPT='$(kube_ps1)'$PROMPT
