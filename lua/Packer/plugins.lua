-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Nvim-tree and icons
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

  -- ColorScheme
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  
  -- like winbar
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
    },
    -- after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
    require("barbecue").setup()
    end,
  })

  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- cursorline
  use { 'yamatsum/nvim-cursorline' }

  -- Coc.nvim
  use {'neoclide/coc.nvim', branch = 'release'}
end)
