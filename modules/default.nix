{...}: {
  imports =
    [(import ../modules/dev/git)]
    ++ [(import ../modules/dev/neovim)]
    ++ [(import ../modules/dev/tmux)]
    ++ [(import ../modules/dev/zsh)]
    ++ [(import ../modules/wayland)]
    ++ [(import ../modules/gnome)];
}
