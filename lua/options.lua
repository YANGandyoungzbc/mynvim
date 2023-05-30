-- :help options 查看options
local options = {
  backup = false,		          -- 备份文件
  clipboard = "unnamedplus",		  -- 使用系统剪切板
  cmdheight = 2,                           -- 显示两行命令行;more space in the neovim command line for displaying messages 
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- ``在markdown中可见;so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- 使用utf-8编码；the encoding written to a file
  hlsearch = true,                         -- 搜索高亮;highlight all matches on previous search pattern
  incsearch = true,                        -- 边输入边搜索
  ignorecase = true,                       -- 忽略大小写;ignore case in search patterns
  mouse = "a",                             -- 使用鼠标;allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- 将撤销操作保存在一个文件里;enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- 把tab转换成空格;convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  wildmenu = true,                         -- 补全增强
  -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

