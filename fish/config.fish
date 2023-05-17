fish_vi_key_bindings

set -U fish_greeting ""

set -gx SHELL (which fish)
set -gx XDG_CONFIG_HOME "/home/rrentea/.config"
set -gx WORK_DIR "/work/bd"
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx BETTER_EXCEPTIONS 1
set -gx PYTHON_CONFIGURE_OPTS "--enable-shared"
set -U SXHKD_SHELL /usr/bin/bash
set -Ux PYENV_ROOT $HOME/.pyenv

set -U FZF_COMPLETE 1

fish_add_path $PYENV_ROOT/bin
fish_add_path /home/rrentea/tools/lua-language-server/bin
fish_add_path /home/rrentea/neovim/bin
fish_add_path /usr/include/python3.9
fish_add_path /home/rrentea/.local/bin
fish_add_path /home/rrentea/.local/kitty.app/bin
fish_add_path /home/rrentea/bin
fish_add_path /home/rrentea/.spicetify
fish_add_path /home/rrentea/.deno/bin/

bind -M insert \cl accept-autosuggestion
bind -M insert \ck up-or-search
bind -M insert \cj down-or-search
bind \cl accept-autosuggestion
bind \ck up-or-search
bind \cj down-or-search
bind -M insert \cp tmux neww tmux-sessionizer


if status is-interactive
    alias l="exa -l -h"
    alias ll="exa -l -h"
    alias la="exa -l -a -h"
    alias ls="exa"

    alias r="ranger"
    alias ran="ranger"

    alias python=python3
    alias pip=pip3

    alias vim=nvim
    alias vi=nvim
    alias v=nvim

    alias ta="tmux attach"
    alias ts="tmux new -s"
    alias cl="wc -l"

    alias env="source env/bin/activate.fish"
    alias venv="source venv/bin/activate.fish"
    alias wenv="source /work/bd/work_env/bin/activate.fish"

    alias luamake="/home/rrentea/tools/lua-language-server/3rd/luamake/luamake"
    alias lldb-vscode="/home/rrentea/bin/extension/adapter/codelldb"

    alias tree="erdtree"
end

zoxide init fish | source
pyenv init - | source


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rrentea/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/rrentea/Downloads/google-cloud-sdk/path.fish.inc'; end
starship init fish | source
