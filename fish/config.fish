fish_vi_key_bindings
set -g fish_greetings

set -gx SHELL "$(which fish)"
set -gx XDG_CONFIG_HOME "/home/rrentea/.config"
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -U SXHKD_SHELL /usr/bin/bash

fish_add_path /home/rrentea/tools/lua-language-server/bin
fish_add_path /home/rrentea/neovim/bin
fish_add_path /usr/include/python3.9
fish_add_path /home/rrentea/.local/bin
fish_add_path /home/rrentea/bin

if status is-interactive
    abbr --add --global l "exa -l --color=auto"
    abbr --add --global la "exa -alh --color=auto"

    abbr --add --global python python3
    abbr --add --global pip pip3

    abbr --add --global vim nvim
    abbr --add --global vi nvim
    abbr --add --global v nvim

    abbr --add --global ta "tmux attach"
    abbr --add --global cl "wc -l"
    abbr --add --global cf "source /home/rrentea/bin/cf"

    abbr --add --global env "source env/bin/activate.fish"
    abbr --add --global venv "source env/bin/activate.fish"
    abbr --add --global wenv "source /home/rrentea/Work/work_env/bin/activate.fish"

    abbr --add --global luamake "/home/rrentea/tools/lua-language-server/3rd/luamake/luamake"
end

zoxide init fish | source
