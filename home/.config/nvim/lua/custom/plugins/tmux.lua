return {
  'christoomey/vim-tmux-navigator',
  init = function()
    -- This prevents the plugin from creating the default <c-\> mapping
    vim.g.tmux_navigator_no_mappings = 1
  end,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<c-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'Move to left pane' },
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'Move to bottom pane' },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'Move to upper pane' },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'Move to right pane' },
    -- { [[<c-\>]], '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Move to previous pane' },
  },
}
