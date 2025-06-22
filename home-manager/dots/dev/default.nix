{...}: {
  imports =
    [(import ./git)]
    ++ [(import ./neovim)]
    ++ [(import ./tmux)];
}
