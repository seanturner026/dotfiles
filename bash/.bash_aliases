# ea - alias for editing aliases
alias ea='nvim ~/.bash_aliases; source ~/.bash_aliases && source $HOME/.bash_aliases && echo "aliases sourced  --ok."'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."

alias alpha="echo ABCDEFGHIJKLMNOPQRSTUVWXYZ"

alias bat="bat --theme=TwoDark"

alias c="clear"
alias cgpap="code . && git pull --all --prune"

alias dcp="echo docker container prune --force && docker container prune --force"
alias dg="docker | grep"
alias deit="docker exec -it"
alias di="docker images"
alias dk="docker kill"
alias dl="docker logs"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dritrm="docker run -it --rm"
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
alias gpbl="git pullb" # This catches gplb typos
alias gplb="git pullb"
alias gpbh="git pushb" # This catches gphb typos
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

alias compdef kdcm="echo kubectl describe configmap && kubecolor describe configmap"
alias compdef kdelp="echo kubectl delete pod && kubecolor delete pod"
alias compdef kdi="echo kubectl describe ingress && kubecolor describe ingress"
alias compdef kdp="echo kubectl describe pod && kubecolor describe pod"
alias compdef kdnc="echo kubectl describe nodeclaim && kubecolor describe nodeclaim"
alias compdef kds="echo kubectl describe service && kubecolor describe service"
alias compdef kdsa="echo kubectl describe serviceaccount && kubecolor describe serviceaccount"
alias compdef kdsec="echo kubectl describe secret && kubecolor describe secret"

alias ke="kubectl explain"
alias compdef keit="echo kubectl exec -it && kubecolor exec -it"

alias compdef kgcm="echo kubectl get configmap && kubecolor get configmap"
alias compdef kgcmy="echo kubectl get configmap -o yaml && kubecolor get configmap -o yaml"
alias compdef kgd="echo kubectl get deployment && kubecolor get deployment"
alias compdef kgdy="echo kubectl get deployment -o yaml && kubecolor get deployment -o yaml"
alias compdef kgi="echo kubectl get ingress && kubecolor get ingress"
alias compdef kgiy="echo kubectl get ingress -o yaml && kubecolor get ingress -o yaml"
alias compdef kgn="echo kubectl get node && kubecolor get node"
alias compdef kgnc="echo kubectl get nodeclaim && kubecolor get nodeclaim"
alias compdef kgncs="echo kubectl get nodeclaim --sort-by=.metadata.creationTimestamp && kubecolor get nodeclaim --sort-by=.metadata.creationTimestamp"
alias compdef kgncg="echo 'kubectl get nodeclaim | grep' && kubecolor get nodeclaim | grep"
alias compdef kgp="echo kubectl get pod && kubecolor get pod"
alias compdef kgpa="echo kubectl get pod -A && kubecolor get pod -A"
alias compdef kgpawg="echo 'kubectl get pod -A -o wide | grep' && kubecolor get pod -A -o wide | grep"
alias compdef kgps="echo kubectl get pod --sort-by=.metadata.creationTimestamp && kubecolor get pod --sort-by=.metadata.creationTimestamp"
alias compdef kgpg="echo 'kubectl get pod | grep' && kubecolor get pod | grep"
alias compdef kgplc="echo kubectl get pod -o jsonpath='{.spec.containers[*].name}' && kubecolor get pod -o jsonpath='{.spec.containers[*].name}'"
alias compdef kgpw="echo kubectl klock pod && kubecolor klock pod"
alias compdef kgpy="echo kubectl get pod -o yaml && kubecolor get pod -o yaml"
alias compdef kgr="echo kubectl get rollouts && kubecolor get rollouts"
alias compdef kgs="echo kubectl get service && kubecolor get service"
alias compdef kgsa="echo kubectl get serviceaccount && kubecolor get serviceaccount"
alias compdef kgsay="echo kubectl get serviceaccount -o yaml && kubecolor get serviceaccount -o yaml"
alias compdef kgsec="echo kubectl get secret && kubecolor get secret"
alias compdef kgsecy="echo kubectl get secret -o yaml && kubecolor get secret -o yaml"
alias compdef kgsy="echo kubectl get service -o yaml && kubecolor get service -o yaml"

alias compdef kl="echo kubectl logs && kubecolor logs"
alias compdef klf="echo kubectl logs -f && kubecolor logs -f"

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
alias td="tree -d -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv'"
alias tda="tree -d -a -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv'"
alias tdag="tree -d -a -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"
alias tdg="tree -d -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"
alias tg="tree -C -I '.DS_Store|.git|.ipynb_checkpoints|__pycache__|node_modules|vendor|*.pyc|venv' | grep"

alias tf="echo terraform && terraform"
alias tfa="echo terraform apply && terraform apply"
alias tfc="echo terraform console && terraform console"
alias tfi="echo terraform init && terraform init"
alias tfiam='echo "pbpaste | iam-policy-json-to-terraform | pbcopy && echo Done" && pbpaste | iam-policy-json-to-terraform | pbcopy && echo "Done"'
alias tfims="echo terraform init -migrate-state && terraform init -migrate-state"
alias tfiu="echo terraform init -upgrade && terraform init -upgrade"
alias tfo="echo terraform output && terraform output"
alias tfp="echo terraform plan && terraform plan"
alias tfsl="echo terraform state list && terraform state list"
alias tfsm="echo terraform state mv && terraform state mv"
alias tfsrm="echo terraform state rm && terraform state rm"
alias tfss="echo terraform state show && terraform state show"
alias tfv="echo terraform validate && terraform validate"
alias tfwl="echo terraform workspace list && terraform workspace list"
alias tfwn="echo terraform workspace new && terraform workspace new"
alias tfws="echo terraform workspace select && terraform workspace select"

alias tmuxr="tmux source-file ~/.tmux.conf"

alias vimdiff='nvim -d'

alias ytop="ytop -c solarized-dark"

alias zg="cat ~/.bash_aliases | grep"
