vim.opt.backup = false
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.signcolumn = "number"
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.wrap = false

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>q", ":wq<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>Q", ":q!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>e", ":Explore<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":noh<CR>", { noremap = true, silent = true })

-- ================================================================================
-- - Lazy.nvim
-- ================================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{
			"neanias/everforest-nvim",
			version = false,
			lazy = false,
			priority = 1000, -- make sure to load this before all the other start plugins
			-- Optional; default configuration will be used if setup isn't called.
			config = function()
				require("everforest").setup({
					-- Your config here
				})
			end,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/vim-vsnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		{
			"ray-x/lsp_signature.nvim",
			event = "InsertEnter",
			opts = {
				-- cfg options
			},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "everforest" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
})

-- ================================================================================
-- - Everforest
-- ================================================================================

require("everforest").load()

-- ================================================================================
-- - LSP
-- ================================================================================

require("mason").setup()
require("mason-lspconfig").setup()

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
})

-- vscode-autohotkey2-lsp
local function custom_attach(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		use_lspsaga = false,
		floating_window = true,
		fix_pos = true,
		hint_enable = true,
		hi_parameter = "Search",
		handler_opts = { "double" },
	})
end
local ahk2_configs = {
	autostart = true,
	cmd = {
		"node",
		vim.fn.expand("$HOME/.local/share/nvim-data/lsp/vscode-autohotkey2-lsp/server/dist/server.js"),
		"--stdio"
	},
	filetypes = { "ahk", "autohotkey", "ah2" },
	init_options = {
		locale = "en-us",
		InterpreterPath = "C:/Program Files/AutoHotkey/v2/AutoHotkey.exe",
		-- Same as initializationOptions for Sublime Text4, convert json literal to lua dictionary literal
	},
	single_file_support = true,
	flags = { debounce_text_changes = 500 },
	capabilities = capabilities,
	on_attach = custom_attach,
}
local configs = require "lspconfig.configs"
configs["ahk2"] = { default_config = ahk2_configs }
local nvim_lsp = require("lspconfig")
nvim_lsp.ahk2.setup({})


-- ================================================================================
-- - Completion
-- ================================================================================

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-l>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm { select = true },
	}),
	experimental = {
		ghost_text = true,
	},
})
