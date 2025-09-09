{
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
    require('outline').setup({})

    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
        vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = '*',
    })
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
}
