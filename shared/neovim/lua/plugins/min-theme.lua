return {
  'datsfilipe/min-theme.nvim',
  config = function()
    require('min-theme').setup({
        theme = 'dark',
        transparent = true,
        italics = {
          comments = true,
        },
      })
  end,
}
