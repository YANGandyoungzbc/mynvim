-- COC keymaps in Packer/coc.lua
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)  -- opten file tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)  -- opten file tree
-- nvim-tree-help
-- -- g?
keymap("n", "<leader>w", ":w<cr>", opts)  -- opten file tree
keymap("n", "<leader>q", ":q<cr>", opts)  -- opten file tree

-- 分屏
keymap("n", "s", "", opts)  -- 取消 s 的默认功能
keymap("n", "sv", ":vsp<CR>", opts)  -- 左右分屏
keymap("n", "sh", ":sp<CR>", opts)  -- 上下分屏
keymap("n", "sc", "<C-w>c", opts)  -- 关闭当前窗口
keymap("n", "so", "<C-w>o", opts)  -- 关闭其他窗口

-- 关闭当前Buffer
keymap("n", "sb", ":bdelete<CR>", opts)  -- 关闭其他窗口

-- terminal
keymap("n", "<leader>t", ":sp | terminal<CR>", opts)  -- 关闭其他窗口

-- 行内移动
keymap("n", "gh", "^", opts)  -- 移动到行首
keymap("n", "gl", "$", opts)  -- 移动到行尾

-- 行间移动
keymap("n", "j", "gj", opts)  -- 移动下一行
keymap("n", "k", "gk", opts)  -- 移动上一行


-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers 切换buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)  -- 覆盖粘贴

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation 在termnal和其他窗口移动
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)
