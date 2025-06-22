{
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        tm = "tmux";
        v = "nvim";
        lg = "lazygit";
        ns = "sudo nixos-rebuild switch --flake ~/nix#default";
        nt = "sudo nixos-rebuild test --flake ~/nix#default";
      };
      # oh-my-zsh = {
      #   enable = true;
      #   theme = "catppuccin_mocha";
      # };
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "catppuccin_mocha";
    };
  };
}
