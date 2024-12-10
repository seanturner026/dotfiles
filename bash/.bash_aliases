# ea - alias for editing aliases
alias ea='nvim ~/.bash_aliases; source ~/.bash_aliases && source $HOME/.bash_aliases && echo "aliases sourced  --ok."'

alias  ..="cd .."
alias  ...="cd ../.."
alias  ....="cd ../../.."
alias  .....="cd ../../../.."
alias  ......="cd ../../../../.."
alias  .......="cd ../../../../../.."
alias  ........="cd ../../../../../../.."
alias  .........="cd ../../../../../../../.."

alias bat="bat --theme=TwoDark"

alias c="clear"
alias cgpap="code . && git pull --all --prune"

alias dg="d | grep"
alias deit="docker exec -it"
alias di="docker images"
alias dil="docker images | sed -n '2p' | awk '{print \$3}' | pbcopy"
alias dk="docker kill"
alias dl="docker logs"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dpsl="docker ps | sed -n '2p' | awk '{print \$1}'"
alias dritrm="docker run -it --rm"
alias drmid="docker rmi $(docker images --filter 'dangling=true' -q --no-trunc)"
alias drmif="docker rmi -f"
alias dsa="docker ps -q | xargs docker stop"

alias ecc="cp ~/code/github/seanturner026/dotfiles/.editorconfig ."
alias eccf="cp -f ~/code/github/seanturner026/dotfiles/.editorconfig ."

alias ga="git add"

alias gb="git branch"
alias gbd="git branch -d"
alias gbD="git for-each-ref --format='%(refname:short)' refs/heads | fzf -m | xargs git branch -D"

alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcof="git for-each-ref --format='%(refname:short)' refs/heads | fzf | xargs git checkout"
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"

alias gd="git diff"

alias gfo="git fetch origin"

alias ggu="go get -u"

alias gl="git log --format=format:'%C(auto)%h %C(green)%aN%Creset %s' --graph"

alias gpap="git pull --all --prune"
alias gplb="git pullb"
alias gphb="git pushb"
alias gpof="git for-each-ref --format='%(refname:short)' refs/heads | fzf | xargs git push -f origin"

alias grai="git rebase --autosquash -i"
alias gri="git rebase -i"
alias grh="git reset --hard"
alias grs="git restore --staged"

alias gs="git show"
alias gsl="git stash list"
alias gspi="git stash pop --index"
alias gss="git stash save"
alias gss0="git stash show -p stash@{0} >~/.diff && vim ~/.diff"
alias gss1="git stash show -p stash@{1} >~/.diff && vim ~/.diff"
alias gss2="git stash show -p stash@{2} >~/.diff && vim ~/.diff"
alias gst="git status"

alias hg="history | grep"

alias compdef k="kubecolor"

alias kctx="kubectx"

alias compdef kdcm="kubecolor describe configmap"
alias compdef kdelp="kubecolor delete pod"
alias compdef kdi="kubecolor describe ingress"
alias compdef kdp="kubecolor describe pod"
alias compdef kds="kubecolor describe service"
alias compdef kdsa="kubecolor describe serviceaccount"
alias compdef kdsec="kubecolor describe secret"

alias compdef keit="kubecolor exec -it"

alias compdef kgcm="kubecolor get configmap"
alias compdef kgcmy="kubecolor get configmap -o yaml"
alias compdef kgd="kubecolor get deployment"
alias compdef kgdy="kubecolor get deployment -o yaml"
alias compdef kgi="kubecolor get ingress"
alias compdef kgiy="kubecolor get ingress -o yaml"
alias compdef kgn="kubecolor get node"
alias compdef kgnc="kubecolor get nodeclaim"
alias compdef kgp="kubecolor get pod"
alias compdef kgplc="kubecolor get pod -o jsonpath='{.spec.containers[*].name}'"
alias compdef kgpw="kubecolor get pod -w"
alias compdef kgpy="kubecolor get pod -o yaml"
alias compdef kgr="kubecolor get rollouts"
alias compdef kgs="kubecolor get service"
alias compdef kgsa="kubecolor get serviceaccount"
alias compdef kgsay="kubecolor get serviceaccount -o yaml"
alias compdef kgsec="kubecolor get secret"
alias compdef kgsecy="kubecolor get secret -o yaml"
alias compdef kgsy="kubecolor get service -o yaml"

alias compdef kl="kubecolor logs"
alias compdef klf="kubecolor logs -f"

alias kns="kubens"

alias ls="/opt/homebrew/opt/coreutils/bin/gls \
  -lhAGH \
  --color=always \
  -I .DS_Store \
  -I .ipynb_checkpoints \
  -I .vscode \
  -I __pycache__"
alias lsg="ls | grep"

alias n="nvim"
alias ng="cat ~/Dropbox/notes.md | grep"
alias npw="python -c \"import string; import random; print(''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=30)))\" | pbcopy"

alias pylc="cp ~/python/github/dotfiles/.pylintrc ."
alias pylcf="cp -f ~/python/github/dotfiles/.pylintrc ."

alias rl="source ~/.zshrc"

alias sls="serverless"
alias slsd="serverless deploy"
alias slsws="serverless wsgi serve"

alias t="tree -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv'"
alias ta="tree -a -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv'"
alias tag="tree -a -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias td="tree -d -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv'"
alias tda="tree -d -a -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv'"
alias tdag="tree -d -a -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"
alias tdg="tree -d -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"
alias tg="tree -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"

alias tf="terraform"
alias tfa="terraform apply"
alias tfc="terraform console"
alias tfi="terraform init"
alias tfiam='pbpaste | iam-policy-json-to-terraform | pbcopy && echo "Done"'
alias tfims="terraform init -migrate-state"
alias tfiu="terraform init -upgrade"
alias tfo="terraform output"
alias tfp="terraform plan"
alias tfpo="tfp --out=plan && terraform show -no-color plan > tfplan && rm plan"
alias tfsl="terraform state list"
alias tfsm="terraform state mv"
alias tfsp="terraform state pull"
alias tfsrm="terraform state rm"
alias tfss="terraform state show"
alias tfv="terraform validate"
alias tfwl="terraform workspace list"
alias tfwn="terraform workspace new"
alias tfws="terraform workspace select"

alias tmuxr="tmux source-file ~/.tmux.conf"

alias ytop="ytop -c solarized-dark"

alias zg="cat ~/.bash_aliases | grep"
