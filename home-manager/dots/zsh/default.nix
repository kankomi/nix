{
  config,
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
              network-status = "sudo journalctl -u wsl-network.service -f | grep -v \"sudo\"";
              px-status = "sudo journalctl -u px-proxy.service -f | grep -v \"sudo\"";
              vpnkit-status = "sudo journalctl -u wsl-vpnkit.service -f | grep -v \"sudo\"";
              network-restart = "sudo systemctl restart wsl-network.service";
              px-restart = "sudo systemctl restart px-proxy.service";
              vpnkit-restart = "sudo systemctl restart wsl-vpnkit.service";
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
  };
}
