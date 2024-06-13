{
  config,
  pkgs,
  ...
}: {
  programs = {
   zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      shellAliases = {
        tm = "tmux";
        v = "nvim";
        lg = "lazygit";
        ns = "sudo nixos-rebuild switch --flake ~/nix-setup#default";
        nt = "sudo nixos-rebuild test --flake ~/nix-setup#default";
      };
      shellInit = ''
      eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin.omp.json)"
      '';
   };
   oh-my-posh = {
       enable = true;

     };
   };
}
