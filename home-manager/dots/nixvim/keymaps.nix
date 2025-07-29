[
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
]