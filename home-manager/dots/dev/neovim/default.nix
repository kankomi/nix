{
  pkgs,
  lib,
  ...
}: let
  fromGitHub = rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
  nvim-plugintree = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.nix
    p.bash
    p.python
    p.yaml
    p.markdown
  ]);
in {
  home.packages = with pkgs; [
    alejandra
    stylua
    nodePackages.vim-language-server
    lua-language-server
    gopls
    gofumpt
    tree-sitter
    nil
  ];
  programs = {
    neovim = {
      plugins = [
        {
          plugin = pkgs.vimPlugins.neo-tree-nvim;
          config = builtins.readFile ./config/setup/neo-tree.lua;
          type = "lua";
        }
        pkgs.vimPlugins.go-nvim
        pkgs.vimPlugins.nui-nvim
        pkgs.vimPlugins.vim-tmux-navigator
        pkgs.vimPlugins.which-key-nvim
        pkgs.vimPlugins.rustaceanvim
        pkgs.vimPlugins.rust-tools-nvim
        {
          plugin = pkgs.vimPlugins.conform-nvim;
          config = builtins.readFile ./config/setup/conform.lua;
          type = "lua";
        }
        ## Theme
        {
          plugin = pkgs.vimPlugins.tokyonight-nvim;
          config = "vim.cmd[[colorscheme tokyonight-night]]";
          type = "lua";
        }

        ## Treesitter
        {
          plugin = pkgs.vimPlugins.nvim-treesitter;
          config = builtins.readFile ./config/setup/treesitter.lua;
          type = "lua";
        }
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        pkgs.vimPlugins.nvim-treesitter-textobjects
        {
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          config = builtins.readFile ./config/setup/lspconfig.lua;
          type = "lua";
        }

        pkgs.vimPlugins.plenary-nvim

        ## Telescope
        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          config = builtins.readFile ./config/setup/telescope.lua;
          type = "lua";
        }
        pkgs.vimPlugins.telescope-fzf-native-nvim
        # pkgs.vimPlugins.harpoon

        ## cmp
        {
          plugin = pkgs.vimPlugins.nvim-cmp;
          config = builtins.readFile ./config/setup/cmp.lua;
          type = "lua";
        }
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.cmp-cmdline
        pkgs.vimPlugins.cmp_luasnip

        ## Tpope
        pkgs.vimPlugins.vim-surround
        pkgs.vimPlugins.vim-sleuth
        pkgs.vimPlugins.vim-repeat
        {
          plugin = fromGitHub "afd76df166ed0f223ede1071e0cfde8075cc4a24" "main" "TabbyML/vim-tabby";
          config = ''
            vim.cmd([[
              let g:tabby_keybinding_accept = '<Tab>'
            ]])
          '';
          type = "lua";
        }

        ## QoL
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.rainbow
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.surround-nvim
        pkgs.vimPlugins.lazygit-nvim
        pkgs.vimPlugins.nvim-code-action-menu
        {
          plugin = pkgs.vimPlugins.neorg;
          config = builtins.readFile ./config/setup/neorg.lua;
          type = "lua";
        }
        # {
        #   # Updated 07/06/24
        #   plugin = fromGitHub "30fe1b3de2b7614f061be4fc9c71984a2b87e50a" "main" "m-demare/hlargs.nvim";
        #   config = "require('hlargs').setup()";
        #   type = "lua";
        # }
        # {
        #   # Updated 07/06/24
        #   plugin = fromGitHub "a0ae099c7eb926150ee0a126b1dd78086edbe3fc" "main" "apple/pkl-neovim";
        # }
        # {
        #   # Updated 07/06/24
        #   plugin = fromGitHub "c6bd6d93e4724ac2dc0cae73ebe1d568bf406537" "main" "epwalsh/obsidian.nvim";
        #   config = ''
        #     require("obsidian").setup({
        #       workspaces = {
        #         {
        #           name = "notes",
        #           path = "~/dev/notes",
        #         },
        #       },
        #     })
        #   '';
        #   type = "lua";
        # }
        # (fromGitHub "8843b72822151bb7792f3fdad4b63df0bc1dd4a6" "main" "MattCairns/telescope-cargo-workspace.nvim")
        {
          plugin = pkgs.vimPlugins.oil-nvim;
          config = "require('oil').setup()";
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.fidget-nvim;
          config = "require('fidget').setup{}";
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.trouble-nvim;
          config = "require('trouble').setup {}";
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.luasnip;
          config = builtins.readFile ./config/setup/luasnip.lua;
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.sniprun;
          config = "require('sniprun').setup()";
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.comment-nvim;
          config = "require('Comment').setup()";
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.gitsigns-nvim;
          config = "require('gitsigns').setup()";
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.lualine-nvim;
          config = ''
            require('lualine').setup {
                options = {
                    theme = 'tokyonight',
                }
            }
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.noice-nvim;
          config = ''
            require("noice").setup({
              lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                  ["cmp.entry.get_documentation"] = true,
                },
              },
              -- you can enable a preset for easier configuration
              presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
              },
            })
          '';
          type = "lua";
        }

        ## Debugging
        pkgs.vimPlugins.nvim-dap-ui
        pkgs.vimPlugins.nvim-dap-virtual-text
        {
          plugin = pkgs.vimPlugins.nvim-dap;
          config = builtins.readFile ./config/setup/dap.lua;
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.rustaceanvim;
          config = ''
            vim.g.rustaceanvim = {
              -- Plugin configuration
              tools = {
              },
              -- LSP configuration
              server = {
                on_attach = function(client, bufnr)
                  -- you can also put keymaps in here
                end,
                settings = {
                  -- rust-analyzer language server configuration
                  ['rust-analyzer'] = {
                   cargo = {
                      allFeatures = true,
                      loadOutDirsFromCheck = true,
                      runBuildScripts = true,
                    },
                    checkOnSave = {
                      allFeatures = true,
                      command = "clippy",
                      extraArgs = { "--no-deps" },
                    },
                    procMacro = {
                      enable = true,
                      ignored = {
                        ["async-trait"] = { "async_trait" },
                        ["napi-derive"] = { "napi" },
                        ["async-recursion"] = { "async_recursion" },
                      },
                    },
                  },
                },
              },
              -- DAP configuration
              dap = {
              },
            }
          '';
          type = "lua";
        }
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./config/mappings.lua}
        ${builtins.readFile ./config/options.lua}
      '';
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
