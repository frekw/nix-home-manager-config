# Run the env.sh script (if it exists). That script is meant to contain secrets, tokens, and
# other things you don't want to put in your Nix config
if [ -e ~/.env.sh ]; then
  . ~/.env.sh
fi

export PATH="${PATH}:${HOME}/.krew/bin:${HOME}/bin"
export WORDCHARS=''
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

autoload -Uz incarg
zle -N incarg
bindkey -M vicmd '^a' incarg

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line