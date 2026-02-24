return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = { [[<c-\>]] }, -- Shortcut to toggle
      direction = 'float', -- This makes it a floating window
      auto_scroll = true,
      persist_mode = true,
      float_opts = {
        border = 'curved', -- Professional look
      },
    }
  end,
}
