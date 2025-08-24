{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  coc = import ./coc.nix;
  cfg = config.myapps.nixvim;
  plugins = import ./plugins.nix { inherit pkgs lib cfg; };
  keymaps = import ./keymaps.nix;
  options = import ./options.nix;
  autocmds = import ./autocmds.nix;
  highlights = import ./highlights.nix;
  globals = import ./globals.nix;
  extraconfig = import ./extraconfig.nix;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.myapps.nixvim = {
    enable = lib.mkEnableOption {
      default = true;
      description = "Enable nixvim, a Neovim configuration using Nix and Home Manager.";
    };
    featureWebDev = lib.mkEnableOption {
      default = false;
      description = "Enable web development features in nixvim.";
    };
    featureCopilot = lib.mkEnableOption {
      default = false;
      description = "Enable Copilot features in nixvim.";
    };
    featureGo = lib.mkEnableOption {
      default = false;
      description = "Enable Go features in nixvim.";
    };
    featureTerraform = lib.mkEnableOption {
      default = false;
      description = "Enable Terraform features in nixvim.";
    };
    featurePython = lib.mkEnableOption {
      default = false;
      description = "Enable Python features in nixvim.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };

    xdg.configFile = {
      "nvim/coc-settings.json" = {
        source = pkgs.writeText "coc-settings.json" (
          builtins.toJSON (coc {
            homeDir = config.xdg.configHome;
            pkgs = pkgs;
          })
        );
      };
    };

    # packages
    home.packages =
      with pkgs;
      [
        figlet
        ripgrep
        nodejs
        pre-commit
        tree-sitter
        gcc
      ]
      ++ lib.optionals cfg.featureWebDev [
        nodejs
        pnpm
        yarn
        eslint
        prettier
        typescript-language-server
        angular-language-server
        tailwindcss-language-server
      ]
      ++ lib.optionals cfg.featureGo [
        go
        gopls
        gofumpt
        air
        templ
      ]
      ++ lib.optionals cfg.featureTerraform [
        terraform-ls
        terraform
        terraform-docs
        tflint
        jq
        tfsec
      ]
      ++ lib.optionals cfg.featurePython [
        python311
        python311Packages.pylint
        python311Packages.black
        python311Packages.isort
        uv
      ];

    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;

      lsp.servers.angularls.enable = cfg.featureWebDev;
      lsp.servers.terraform_lsp.enable = cfg.featureTerraform;

      inherit (plugins) plugins extraPlugins;
      keymaps = keymaps;
      opts = options;
      autoCmd = autocmds;
      highlight = highlights;
      globals = globals;
      inherit (extraconfig) extraConfigLua extraConfigVim;
    };
  };
}
