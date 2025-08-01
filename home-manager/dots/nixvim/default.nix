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
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

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
      ]
      ++ lib.optionals cfg.featureWebDev [
        nodejs
        pnpm
        yarn
        eslint
        prettier
        typescript-language-server
        angular-language-server
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
      ]
      ++ lib.optionals cfg.featurePython [
        python311
        python311Packages.pylint
        python311Packages.black
        python311Packages.isort
      ];

    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;
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
          terraform-ls
        ]
        ++ lib.optionals cfg.featureCopilot [
          copilot-vim
          CopilotChat-nvim
        ];

      opts = {
        number = true;
        relativenumber = true;
        syntax = "enable";
        fileencodings = "utf-8,sjis,euc-jp,latin";
        encoding = "utf-8";
        title = true;
        autoindent = true;
        background = "dark";
        backup = false;
        hlsearch = true;
        showcmd = true;
        cmdheight = 1;
        laststatus = 2;
        scrolloff = 10;
        expandtab = true;
        shell = "zsh";
        backupskip = "/tmp/*,/private/tmp/*";
        inccommand = "split";
        ruler = false;
        showmatch = false;
        lazyredraw = true;
        ignorecase = true;
        smarttab = true;
        shiftwidth = 2;
        tabstop = 2;
        ai = true;
        ci = true;
        wrap = true;
        backspace = "start,eol,indent";
        path = "vim.opts.path \+ **";
        wildignore = "vim.opts.wildignore \+ */node_modules/*";
        cursorline = true;
        exrc = true;
        mouse = "a";
        suffixesadd = ".js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md";
      };

      autoCmd = [
        {
          event = [
            "BufRead"
            "BufNewFile"
          ];
          pattern = [ "*.tf" ];
          command = "setfiletype tf";
        }

        {
          event = [ "InsertEnter" ];
          pattern = [ "*" ];
          command = "match EOLWS // | match EOLWSInsert /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t/";
        }
        {
          event = [ "InsertLeave" ];
          pattern = [ "*" ];
          command = "match EOLWS // | match EOLWSInsert /\\s\\+\\%#\\@<!$\\| \\+\\ze\\t/";
        }
        {
          event = [
            "WinEnter"
            "BufWinEnter"
            "WinNew"
          ];
          pattern = [ "*" ];
          command = "match EOLWS /\\s\\+$\\| \\+\\ze\t/";
        }
        {
          event = [ "WinEnter" ];
          pattern = [ "*" ];
          command = "set cul";
        }
        {
          event = [ "WinLeave" ];
          pattern = [ "*" ];
          command = "set nocul";
        }
        {
          event = [ "BufWritePre" ];
          pattern = [ "*.go" ];
          command = ":silent call CocAction('runCommand', 'editor.action.organizeImport')";
        }
      ];
      highlight = {
        BufferCurrent = {
          fg = "#eceff4";
          bg = "#434c5e";
          bold = true;
        };
        BufferCurrentMod = {
          fg = "#ebcb8b";
          bg = "#434c5e";
          bold = true;
        };
        BufferCurrentSign = {
          fg = "#4c566a";
          bg = "#4c566a";
        };
        BufferCurrentTarget = {
          bg = "#434c5e";
        };
        BufferInactive = {
          fg = "#4c566a";
          bg = "none";
        };
        BufferInactiveSign = {
          fg = "#4c566a";
          bg = "none";
        };
        BufferInactiveMod = {
          fg = "#ebcb8b";
          bg = "none";
        };
        BufferTabpageFill = {
          fg = "#4c566a";
          bg = "none";
        };
      };
      globals = {
        mapleader = " ";
        coc_filetype_map = {
          "yaml.ansible" = "ansible";
        };
        coc_global_extensions = [
          "coc-explorer"
          "@yaegassy/coc-nginx"
          "coc-nil"
        ];
        suda_smart_edit = 1;
        "suda#nopass" = 1;
      };
      extraConfigLua = ''
        vim.api.nvim_set_hl(0, "MatchParen", { bg="#4c566a", fg="#88c0d0" })

        vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true

        require('CopilotChat').setup{
          window = {
            layout = "vertical",
            width = 60,
          },
          mappings = {
            complete = {
                insert = "<C-l>",
              },
            reset = {
                normal = "<M-l>",
                insert = "<M-l>",
            },
             close = {
              normal = "q",
              insert = "",
            },
          },
        }
      '';
      extraConfigVim = ''
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
        set undofile
        set clipboard+=unnamedplus
        function CheckForExplorer()
          if CocAction('runCommand', 'explorer.getNodeInfo', 'closest') isnot# v:null
            CocCommand explorer --toggle
          endif
        endfunction

        " Use K to show documentation in preview window
        nnoremap <silent> K :call ShowDocumentation()<CR>

        function! ShowDocumentation()
          if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
          else
            call feedkeys('K', 'in')
          endif
        endfunction
      '';
      keymaps = [
        {
          mode = "i";
          key = "jj";
          action = "<Esc>";
          options = {
            silent = true;
          };
        }
        {
          mode = "i";
          key = "jk";
          action = "<Esc>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>lg";
          action = "<cmd>LazyGit<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<Esc>";
          action = "<cmd>nohlsearch<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-n>";
          action = "<cmd>CocCommand explorer<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-s>";
          action = ":w<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<S-Tab>";
          action = "<Cmd>BufferPrevious<CR>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<Tab>";
          action = "<Cmd>BufferNext<CR>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>x";
          action = "<Cmd>BufferClose<CR>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>X";
          action = "<Cmd>BufferRestore<CR>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "p";
          action = "p`]<Esc>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>sg";
          action = ":call CheckForExplorer()<CR> <cmd>lua require('telescope.builtin').live_grep()<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>sf";
          action = ":call CheckForExplorer()<CR> <cmd>lua require('telescope.builtin').find_files()<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>sb";
          action = ":call CheckForExplorer()<CR> <cmd>lua require('telescope.builtin').file_browser()<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = ";;";
          action = ":call CheckForExplorer()<CR> <cmd>Telescope buffers<cr>";
          options = {
            silent = true;
          };
        }
        # Code Action
        {
          mode = "n";
          key = "<leader>re";
          action = "<Plug>(coc-codeaction-refactor)";
          options = {
            silent = true;
          };
        }
        {
          mode = "x";
          key = "<leader>r";
          action = "<Plug>(coc-codeaction-refactor-selected)";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>cl";
          action = "<Plug>(coc-codelens-actions)";
          options = {
            silent = true;
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "<leader>d";
          action = ":CocList diagnostics<cr>";
          options = {
            silent = true;
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "<leader>j";
          action = ":CocNext<cr>";
          options = {
            silent = true;
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "<leader>k";
          action = ":CocPrev<cr>";
          options = {
            silent = true;
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "<leader>fm";
          action = ":CocCommand editor.action.formatDocument<cr>";
          options = {
            silent = true;
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "gd";
          action = "<Plug>(coc-definition)";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "gy";
          action = "<Plug>(coc-type-definition)";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "gi";
          action = "<Plug>(coc-implementation)";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "gr";
          action = "<Plug>(coc-references)";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "go";
          action = ":CocList outline<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = "<Plug>(coc-rename)";
        }
        {
          mode = "n";
          key = "<leader>qf";
          action = "<Plug>(coc-fix-current)";
        }
        {
          mode = "i";
          key = "<c-space>";
          action = "coc#refresh()";
          options = {
            silent = true;
            expr = true;
          };
        }
        {
          mode = "i";
          key = "<c-j>";
          action = "<Plug>(coc-snippets-expand-jump)";
          options = {
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>cc";
          action = ":CopilotChatToggle<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "x";
          key = "<leader>co";
          action = ":CopilotChatOptimize<cr>";
          options = {
            silent = true;
          };
        }
        {
          mode = "x";
          key = "<leader>cd";
          action = ":CopilotChatDocs<cr>";
          options = {
            silent = true;
          };
        }
      ];
    };
  };
}
