# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -v
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey '^l' autosuggest-accept
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.histfile
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Path
path+=$PYENV_ROOT/bin
path+=/home/rrentea/tools/lua-language-server/bin
path+=/usr/local/include
path+=/usr/local/
path+=/home/rrentea/.local/bin
path+=/home/rrentea/.local/share/bin
path+=/home/rrentea/bin
path+=/home/rrentea/.cargo/bin/
path+=/usr/local/go/bin/
path+=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
path+=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin

# ENV
export EDITOR=nvim
export BDNC_PATH=/work/bd/ghostr/components/bdnc/latest/linux-release64/libbdnc.so
export HAUT_CVD_PATH=/work/bd/git/ecnet_haut_sigs/bin/haut.cvd
export SID_DATA_PATH=/work/bd/git/ecnet/bin/sid.data
export PORTALIB_PATH=/work/bd/git/portalib/bin/linux-debug64/portalib.so
export ECNET_PATH=/work/bd/git/ecnet/bin/linux-debug64/libEcNet.so

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Aliases
alias l="exa -l -h"
alias ll="exa -l -h"
alias la="exa -l -a -h"
alias ls="exa"
alias r="ranger"
alias ran="ranger"
alias python=python3
alias pip=pip3
alias nvim=nvim
alias vim=nvim
alias vi=nvim
alias v=nvim
alias ta="tmux attach"
alias ts="tmux new -s"
alias env="source env/bin/activate.fish"
alias venv="source venv/bin/activate.fish"
alias wenv="source /work/bd/work_env/bin/activate.fish"
alias luamake="/home/rrentea/tools/lua-language-server/3rd/luamake/luamake"
alias tree="erdtree"
alias yy="y"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# bun completions
[ -s "/home/rrentea/.bun/_bun" ] && source "/home/rrentea/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
