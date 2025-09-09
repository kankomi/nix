{
  pkgs,
  lib,
  cfg,
}:
{
  plugins = {
    notify.enable = true;
    web-devicons = {
      enable = true;
    };
    barbecue.enable = true;
    markview.enable = true;
    leap = {
      enable = true;
    };
    telescope = {
      enable = true;
    };
    conform-nvim = {
      enable = true;
      settings = {
        formatter_by_ft = {
          go = [ "gofumpt" ];
          python = [
            "ruff_fix"
            "ruff_format"
            "ruff_organize_imports"
          ];
          tf = [ "terraform-fmt" ];
          templ = [ "goimports" ];
        };
      };
    };
    treesitter = {
      enable = true;
      settings = {
        ensure_installed =
          [ ]
          ++ lib.optionals cfg.featureWebDev [
            "angular"
            "typescript"
            "tsx"
            "html"
            "css"
            "javascript"
          ]
          ++ lib.optionals cfg.featureGo [
            "go"
          ]
          ++ lib.optionals cfg.featurePython [
            "python"
          ]
          ++ lib.optionals cfg.featureTerraform [
            "terraform"
          ];
      };
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
          "tsx"
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
      coc-markdownlint
      vim-suda
      vim-tmux-navigator
      lazygit-nvim
      friendly-snippets
      outline-nvim
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
      tailwind-tools-nvim
    ]
    ++ lib.optionals cfg.featureGo [
      coc-go
      templ-vim
      tailwindcss-colors-nvim
    ]
    ++ lib.optionals cfg.featureTerraform [
      vim-terraform
    ]
    ++ lib.optionals cfg.featurePython [
      coc-pyright
    ]
    ++ lib.optionals cfg.featureCopilot [
      copilot-vim
      CopilotChat-nvim
    ];
}
