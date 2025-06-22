{...}: {
  imports =
    [(import ../modules/dev/git)]
    ++ [(import ../modules/dev/neovim)]
    ++ [(import ../modules/dev/tmux)]
    ++ [(import ../modules/dev/zsh)]
    ++ [(import ../modules/dev/btop)]
    # ++ [(import ../modules/hyprland)]
    ++ [(import ../modules/apps/usb)]
    ++ [(import ../modules/gnome)];
}
