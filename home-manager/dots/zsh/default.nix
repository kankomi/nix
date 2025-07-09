{
  config,
  lib,
  ...
}:
{
  imports = [
    ../starship
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases =
        {
          tm = "tmux";
          lg = "lazygit";
          ns = "sudo nixos-rebuild switch --flake ~/nix#laptop";
          nt = "sudo nixos-rebuild test --flake ~/nix#laptop";
          v = "nvim";
          ls = "ls -h --color";
          l = "ls -lh";
          ll = "l";
          la = "ls -la";
        }
        // (
          if config.home.username == "gpa9bh" then
            {
              hms = "home-manager switch --flake /home/gpa9bh/nix#wsl";
            }
          else
            { }
        );
      initContent =
        if config.home.username == "gpa9bh" then
          ''
            source $HOME/.nix-profile/etc/profile.d/nix.sh
            set -a; source /etc/environment; set +a;

            eval "$(starship init zsh)"
          ''
        else
          "";
    };
    # oh-my-posh = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   useTheme = "catppuccin_mocha";
    # };
  };
}
