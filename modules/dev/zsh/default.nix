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
        lg = "lazygit";
        ns = "sudo nixos-rebuild switch --flake ~/nix-setup#default";
        nt = "sudo nixos-rebuild test --flake ~/nix-setup#default";
      };
   };
   oh-my-posh = {
       enable = true;
     };
   };
}
