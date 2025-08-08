{
  config,
  configName,
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
      shellAliases = {
        tm = "tmux";
        lg = "lazygit";
        v = "nvim";
        ls = "ls -h --color";
        l = "ls -lh";
        ll = "l";
        la = "ls -la";
        npm = "pnpm";
        mux = "tmuxinator";
      }
      // (
        if configName == "wsl_bosch" then
          {
            network-status = "sudo journalctl -u wsl-network.service -f | grep -v \"sudo\"";
            px-status = "sudo journalctl -u px-proxy.service -f | grep -v \"sudo\"";
            vpnkit-status = "sudo journalctl -u wsl-vpnkit.service -f | grep -v \"sudo\"";
            network-restart = "sudo systemctl restart wsl-network.service";
            px-restart = "sudo systemctl restart px-proxy.service";
            vpnkit-restart = "sudo systemctl restart wsl-vpnkit.service";
          }
        else
          { }
      )
      // (
        if builtins.match "^wsl.*" configName != null then
          {
            hms = "home-manager switch --flake ~/nix#${configName}";
          }
        else
          {
            ns = "sudo nixos-rebuild switch --flake ~/nix#${configName}";
            nt = "sudo nixos-rebuild test --flake ~/nix#${configName}";
          }
      );

      initContent =
        if configName == "wsl_bosch" then
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
