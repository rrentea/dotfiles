fish_vi_key_bindings

set -U fish_greeting ""

set -gx SHELL (which fish)
set -gx XDG_CONFIG_HOME "/home/rrentea/.config"
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx BETTER_EXCEPTIONS 1
set -U SXHKD_SHELL /usr/bin/bash

set -U FZF_COMPLETE 1

fish_add_path /home/rrentea/tools/lua-language-server/bin
fish_add_path /home/rrentea/neovim/bin
fish_add_path /usr/include/python3.9
fish_add_path /home/rrentea/.local/bin
fish_add_path /home/rrentea/.local/kitty.app/bin
fish_add_path /home/rrentea/bin

if status is-interactive
    alias l="lsd -l"
    alias ll="lsd -l"
    alias la="lsd -l -a"
    alias ls="lsd"

    alias r="ranger"
    alias ran="ranger"

    alias python=python3
    alias pip=pip3

    alias vim=nvim
    alias vi=nvim
    alias v=nvim

    alias ta="tmux attach"
    alias cl="wc -l"
    alias cf="source /home/rrentea/bin/cf"

    alias env="source env/bin/activate.fish"
    alias venv="source env/bin/activate.fish"
    alias wenv="source /home/rrentea/Work/work_env/bin/activate.fish"

    alias luamake="/home/rrentea/tools/lua-language-server/3rd/luamake/luamake"
end

zoxide init fish | source
fish_add_path /home/rrentea/.spicetify

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rrentea/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/rrentea/Downloads/google-cloud-sdk/path.fish.inc'; end
