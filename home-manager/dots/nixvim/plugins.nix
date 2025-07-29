{ pkgs, lib, cfg }:
{
  plugins = {
    notify.enable = true;
    web-devicons = {
      enable = true;
    };
    barbecue.enable = true;
    markview.enable = true;
    project-nvim = {
      enable = true;
    };
    leap = {
      enable = true;
    };
    telescope = {
      enable = true;
    };
    alpha = {
      enable = true;
      theme = "startify";
    };
    fugitive = {
      enable = true;
    };
    trim = {
      enable = true;
      settings = {
        ft_blocklist = [ "coc-explorer" ];
        highlight = false;
      };
    };
    lualine = {
      enable = true;
      settings = {
        sections = {
          lualine_x = [
            "diagnostics"
            "encoding"
            "filetype"
          ];
        };
      };
    };
    indent-blankline = {
      enable = true;
      settings = {
        exclude.filetypes = [ "startify" ];
      };
    };
    barbar = {
      enable = true;
    };
    gitgutter = {
      enable = true;
    };
    vim-surround = {
      enable = true;
    };
    colorizer = {
      enable = true;
      settings = {
        filetypes = [
          "css"
          "scss"
          "html"
          "templ"
        ];
      };
    };
    which-key = {
      enable = true;
    };
    illuminate = {
      enable = true;
    };
  };

  extraPlugins =
    with pkgs.vimPlugins;
    [
      llm-nvim
      coc-nvim
      # coc-snippets
      coc-markdownlint
      vim-suda
      vim-tmux-navigator
      lazygit-nvim
      friendly-snippets
    ]
    ++ lib.optionals cfg.featureWebDev [
      coc-tsserver
      coc-prettier
      coc-html
      coc-css
      coc-json
      coc-emmet
      coc-eslint
      tailwindcss-colors-nvim
    ]
    ++ lib.optionals cfg.featureGo [
      coc-go
      templ-vim
      tailwindcss-colors-nvim
    ]
    ++ lib.optionals cfg.featureTerraform [
      vim-terraform
    ]
    ++ lib.optionals cfg.featureCopilot [
      copilot-vim
      CopilotChat-nvim
    ];
}