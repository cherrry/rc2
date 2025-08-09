return {
  'olimorris/onedarkpro.nvim',
  version = '*',
  lazy = false,
  config = function()
    require('onedarkpro').setup({
        styles = {
          comments = 'italic',
        },
        options = {
          transparency = true,
        },
      })
  end,
}
