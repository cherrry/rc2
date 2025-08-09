return {
  'nvim-lualine/lualine.nvim',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup()
  end,
}
