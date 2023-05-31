-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Install Plugins
require("lazy").setup({
	-- colorscheme
	{
		"RRethy/nvim-base16",
		lazy = true,
	},

	-- telescope.nvim
	{
		-- install
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		cmd = "Telescope", -- 当运行这个命令时，才启动这个插件
		dependencies = { "nvim-lua/plenary.nvim" }, -- 插件的依赖
		keys = {
			-- {'<leader>ff',':Telescope find_files<CR>',desc = '[F]ind [F]iles'},
			-- {'<leader>g',':Telescope live_grep<CR>',desc = '[L]ive [G]rep'},
			-- {'<leader>r',':Telescope resume<CR>',desc = 'Resume'},
			-- {'<leader>of',':Telescope oldfiles<CR>',desc = '[O]ld [F]iles'},
		},
	},

	-- [[ LSP Begin ]]
	-- 下面两个插件的顺序不能变
	-- Mason.nvim
	{
		event = "VeryLazy",
		"williamboman/mason.nvim",
		config = true,
		opts = {},
	},
	{
		-- nvim-lspconfig.nvim
		event = "VeryLazy",
		"neovim/nvim-lspconfig",
		dependencies = {
			-- mason-lspconfig.nvim
			"williamboman/mason-lspconfig.nvim",
			opts = {
				-- 如果没安装这个table中的lsp，那么会自动安装
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"marksman",
					"html",
					"tsserver",
					"cssls",
				},
				automatic_installation = false,
				hadlers = nil,
			},
		},
	},

	-- null-ls.nvim
	{
		event = "VeryLazy",
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			-- null-ls.nvim
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- [[ Formatter ]]
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.clang_format,
					-- null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.formatting.prettier,

				},
			})
		end,
	},
	-- [[ LSP End]]

	-- nvim-cmp
	{
		event = "VeryLazy",
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
		},
	},

	-- neodev
	{
		-- 补全的时候会有一个文档
		"folke/neodev.nvim",
		opts = {},
	},

	-- autopairs
	{
		-- 自动完成括号
		-- 自动为选中的function添加括号
		event = "VeryLazy",
		"windwp/nvim-autopairs",
		opts = {},
	},

	-- nvim-tree
	{
		cmd = "NvimTreeToggle",
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", ":NvimTreeToggle<CR>", desc = "[E]xplorer (NvimTreeToggle)" },
		},
		opts = {
			view = {
				width = 25,
				-- float = {
					-- enable = true,
				-- },
			},
		},
	},
})

-- [[ Plugin Config ]]
-- nvim-lspconfig.nvim
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>de", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>dq", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "=", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- nvim cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- capabilities = capabilities
-- }
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require("cmp")
local luasnip = require("luasnip")
-- auto pair after select a quick input
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body)   -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.abort(), -- 取消
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "vsnip" }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- [[ LSP Config]]
-- lua
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
				},
			},
			completion = {
				callSnippet = "Replace",
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- python
require("lspconfig").pyright.setup({
	capabilities = capabilities,
})

-- C C++
require("lspconfig").clangd.setup({
	capabilities = capabilities,
})

-- markdown
require("lspconfig").marksman.setup({
	capabilities = capabilities,
})

-- html
require("lspconfig").html.setup({
	capabilities = capabilities,
})

-- javascript
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})

-- css
require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

-- java
require("lspconfig").jdtls.setup({
	capabilities = capabilities,
})
