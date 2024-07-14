# ea - alias for editing aliases
alias ea='vim ~/.bash_aliases; source ~/.bash_aliases && source $HOME/.bash_aliases && echo "aliases sourced  --ok."'

alias  ..="cd .."
alias  ...="cd ../.."
alias  ....="cd ../../.."
alias  .....="cd ../../../.."
alias  ......="cd ../../../../.."
alias  .......="cd ../../../../../.."
alias  ........="cd ../../../../../../.."
alias  .........="cd ../../../../../../../.."

alias bat="bat --theme=TwoDark"

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

alias gs="git show"
alias gsl="git stash list"
alias gspi="git stash pop --index"
alias gss="git stash save"
alias gss0="git stash show -p stash@{0} >~/.diff && vim ~/.diff"
alias gss1="git stash show -p stash@{1} >~/.diff && vim ~/.diff"
alias gss2="git stash show -p stash@{2} >~/.diff && vim ~/.diff"
alias gst="git status"

alias hg="history | grep"

alias compdef k="kubectl"

alias kctx="kubectx"

alias compdef kdcm="kubectl describe configmap"
alias compdef kdelp="kubectl delete pod"
alias compdef kdi="kubectl describe ingress"
alias compdef kdp="kubectl describe pod"
alias compdef kds="kubectl describe service"
alias compdef kdsa="kubectl describe serviceaccount"
alias compdef kdsec="kubectl describe secret"

alias compdef keit="kubectl exec -it"

alias compdef kgcm="kubectl get configmap"
alias compdef kgcmy="kubectl get configmap -o yaml"
alias compdef kgd="kubectl get deployment"
alias compdef kgdy="kubectl get deployment -o yaml"
alias compdef kgi="kubectl get ingress"
alias compdef kgiy="kubectl get ingress -o yaml"
alias compdef kgn="kubectl get node"
alias compdef kgnc="kubectl get nodeclaim"
alias compdef kgp="kubectl get pod"
alias compdef kgplc="kubectl get pod -o jsonpath='{.spec.containers[*].name}'"
alias compdef kgpw="kubectl get pod -w"
alias compdef kgpy="kubectl get pod -o yaml"
alias compdef kgr="kubectl get rollouts"
alias compdef kgs="kubectl get service"
alias compdef kgsa="kubectl get serviceaccount"
alias compdef kgsay="kubectl get serviceaccount -o yaml"
alias compdef kgsec="kubectl get secret"
alias compdef kgsecy="kubectl get secret -o yaml"
alias compdef kgsy="kubectl get service -o yaml"

alias compdef kl="kubectl logs"
alias compdef klf="kubectl logs -f"

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
alias tfiam="nvim -c 'startinsert' temp && cat temp | iam-policy-json-to-terraform | pbcopy && rm temp"
alias tfims="terraform init -migrate-state"
alias tfiu="terraform init -upgrade"
alias tfo="terraform output"
alias tfp="terraform plan"
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
