{
  config,
  ...
}:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        tm = "tmux";
        lg = "lazygit";
        ns = "sudo nixos-rebuild switch --flake ~/nix#laptop";
        nt = "sudo nixos-rebuild test --flake ~/nix#laptop";
        v = "nvim";
      };
      initContent =
        if config.home.username == "gpa9bh" then
          ''
            source $HOME/.nix-profile/etc/profile.d/nix.sh
            set -a; source /etc/environment; set +a;
          ''
        else
          "";
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "catppuccin_mocha";
    };
  };
}
