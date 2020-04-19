export ZSH="/Users/sean/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins=(git)

source $ZSH/oh-my-zsh.sh

alias  ..="cd .."
alias  ...="cd ../.."
alias  ....="cd ../../.."
alias  .....="cd ../../../.."
alias  ......="cd ../../../../.."
alias  .......="cd ../../../../../.."

alias di="docker images"
alias dritrm="docker run -it --rm"
alias drmif="docker rmi -f"

alias ga="git add"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcmsg="git commit -m"
alias gd="git diff"
alias gpap="git pull --all --prune"
alias gsl="git stash list"
alias gspi="git stash pop --index"
alias gss="git stash save"
alias gst="git status"

alias k="aws-vault exec wcc-terraform-shared-services -- kubectl"

alias kctx="aws-vault exec wcc-terraform-shared-services -- kubectx"

alias kdcm="aws-vault exec wcc-terraform-shared-services -- kubectl describe configmap"
alias kdi="aws-vault exec wcc-terraform-shared-services -- kubectl describe ingress"
alias kdelp="aws-vault exec wcc-terraform-shared-services -- kubectl delete pod"
alias kdelpn="aws-vault exec wcc-terraform-shared-services -- kubectl delete pod --now"
alias kdp="aws-vault exec wcc-terraform-shared-services -- kubectl describe pod"
alias kds="aws-vault exec wcc-terraform-shared-services -- kubectl describe service"
alias kdsa="aws-vault exec wcc-terraform-shared-services -- kubectl describe serviceaccount"
alias kdsec="aws-vault exec wcc-terraform-shared-services -- kubectl describe secret"

alias keit="aws-vault exec wcc-terraform-shared-services -- kubectl exec -it"

alias kgcm="aws-vault exec wcc-terraform-shared-services -- kubectl get configmap"
alias kgcmy="aws-vault exec wcc-terraform-shared-services -- kubectl get configmap -o yaml"
alias kgd="aws-vault exec wcc-terraform-shared-services -- kubectl get deployment"
alias kgdy="aws-vault exec wcc-terraform-shared-services -- kubectl get deployment -o yaml"
alias kgi="aws-vault exec wcc-terraform-shared-services -- kubectl get ingress"
alias kgiy="aws-vault exec wcc-terraform-shared-services -- kubectl get ingress -o yaml"
alias kgp="aws-vault exec wcc-terraform-shared-services -- kubectl get pod"
alias kgpw="aws-vault exec wcc-terraform-shared-services -- kubectl get pod -w"
alias kgpy="aws-vault exec wcc-terraform-shared-services -- kubectl get pod -o yaml"
alias kgn="aws-vault exec wcc-terraform-shared-services -- kubectl get node"
alias kgs="aws-vault exec wcc-terraform-shared-services -- kubectl get service"
alias kgsy="aws-vault exec wcc-terraform-shared-services -- kubectl get service -o yaml"
alias kgsa="aws-vault exec wcc-terraform-shared-services -- kubectl get serviceaccount"
alias kgsay="aws-vault exec wcc-terraform-shared-services -- kubectl get serviceaccount -o yaml"
alias kgsec="aws-vault exec wcc-terraform-shared-services -- kubectl get secret"
alias kgsecy="aws-vault exec wcc-terraform-shared-services -- kubectl get secret -o yaml"

alias kl="aws-vault exec wcc-terraform-shared-services -- kubectl logs"
alias klf="aws-vault exec wcc-terraform-shared-services -- kubectl logs -f"

alias kns="aws-vault exec wcc-terraform-shared-services -- kubens"

alias python="python3"
alias pip="pip3"

alias reload="source ~/.zshrc"

alias sls="serverless"
alias slsd="serverless deploy"
alias slsws="serverless wsgi serve"

alias t="tree -C -I '.git|__pycache__|node_modules|*.pyc|venv'"
alias ta="tree -a -C -I '.git|__pycache__|node_modules|*.pyc|venv'"
alias td="tree -d -C -I '.git|__pycache__|node_modules|*.pyc|venv'"
alias tda="tree -d -a -C -I '.git|__pycache__|node_modules|*.pyc|venv'"

alias tfa="aws-vault exec wcc-terraform -- terraform apply"
alias tfc="aws-vault exec wcc-terraform -- terraform console"
alias tfi="aws-vault exec wcc-terraform -- terraform init"
alias tfp="aws-vault exec wcc-terraform -- terraform plan"

alias tmuxr="tmux source-file ~/.tmux.conf"

alias venv="source venv/bin/activate"

alias ytop="ytop -c solarized-dark"

export DOCKER_BUILDKIT=1
export PROMPT_EOL_MARK=""

# serverless
export PATH="$HOME/.serverless/bin:$PATH"
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# brew
export PATH="/usr/local/sbin:$PATH"

source ~/.p10k-sean.zsh
