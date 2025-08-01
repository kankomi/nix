vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>x", ":q<cr>", { desc = "Quit Buffer", silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<cr>", { desc = "Save File", silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree toggle<cr>", { desc = "Toggle Neotree", silent = true })
-- basic
vim.api.nvim_set_keymap("n", "<Esc>", "<cmd>nohlsearch<cr>", { noremap = true, silent = true })

-- Conform
vim.keymap.set("n", "<leader>fm", function()
	local bufnr = vim.api.nvim_get_current_buf()
	require("conform").format({ bufnr = bufnr })
end, { desc = "Format current buffer" })

-- lazygit
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>LazyGit<cr>", { noremap = true, silent = true })

-- window navigation
vim.api.nvim_set_keymap(
	"n",
	"<C-h>",
	"<C-w><C-h>",
	{ noremap = true, silent = true, desc = "Move focus to the left window" }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-l>",
	"<C-w><C-l>",
	{ noremap = true, silent = true, desc = "Move focus to the right window" }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-j>",
	"<C-w><C-j>",
	{ noremap = true, silent = true, desc = "Move focus to the lower window" }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-k>",
	"<C-w><C-k>",
	{ noremap = true, silent = true, desc = "Move focus to the upper window" }
)

-- lsp trouble
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble document_diagnostics<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>Trouble lsp_definitions<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tr", "<cmd>Trouble lsp_references<cr>", { noremap = true })

-- telescope
vim.api.nvim_set_keymap("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	"<cmd>lua require('telescope.builtin').diagnostics()<cr>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>si",
	"<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",
	{ noremap = true }
)

-- DAP
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>so", "<cmd>lua require('dap').step_over()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>si", "<cmd>lua require('dap').step_into()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", { noremap = true })

-- SnipRun
vim.api.nvim_set_keymap("n", "<leader>sr", "<cmd>lua require('sniprun').run()<cr>", { noremap = true })

-- Quickfix
vim.api.nvim_set_keymap("n", "<leader>qn", "<cmd>:cn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>qp", "<cmd>:cp<CR>", { noremap = true })

-- Harpoon
-- vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua require("harpoon.mark").add_file()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', { noremap = true })

-- Clang
-- vim.api.nvim_set_keymap('n', '<leader>he', '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true })

-- Oil
vim.api.nvim_set_keymap("n", "<leader>oo", "<cmd>Oil<cr>", { noremap = true })

-- Neorg
vim.api.nvim_set_keymap("n", "<leader>ne", "<cmd>Neorg index<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>nr", "<cmd>Neorg return<cr>", { noremap = true })
