function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx GITHUB_USERNAME connorsmacd

set -gx EDITOR nvim

set -gx VCPKG_ROOT ~/dev/vcpkg
fish_add_path $VCPKG_ROOT

set -g fish_key_bindings fish_vi_key_bindings

starship init fish | source
enable_transience

zoxide init fish | source

fzf --fish | source

load_nvm >/dev/stderr

alias cd=z
alias ls=eza

abbr -a fish-reload-config 'source ~/.config/fish/**/*.fish'

abbr -a restart-aerospace 'osascript -e \'quit app "AeroSpace"\' && open -a AeroSpace'
