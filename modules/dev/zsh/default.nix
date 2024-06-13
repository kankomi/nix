{
  config,
  pkgs,
  ...
}: {
  programs = {
   zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        tm = "tmux";
        v = "nvim";
        ns = "sudo nixos-rebuild switch --flake /etc/nixos/#default";
        nt = "sudo nixos-rebuild test --flake /etc/nixos/#default";
        hs = "home-manager switch -f /etc/nixos/hosts/default/home.nix";
      };
   };
   oh-my-posh = {
       enable = true;
     };
   };
}
