return {
  'NeogitOrg/neogit',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim', -- required

    -- Only one of these is needed.
    'sindrets/diffview.nvim', -- optional
    -- 'esmuellert/codediff.nvim', -- optional

    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim', -- optional
    -- 'ibhagwan/fzf-lua', -- optional
    -- 'nvim-mini/mini.pick', -- optional
    'folke/snacks.nvim', -- optional
  },
  cmd = 'Neogit',
  opts = {
    kind = 'split_below_all',
    commit_editor = {
      kind = 'floating',
      show_staged_diff = true,
      -- Accepted values:
      -- "split" to show the staged diff below the commit editor
      -- "vsplit" to show it to the right
      -- "split_above" Like :top split
      -- "vsplit_left" like :vsplit, but open to the left
      -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
      staged_diff_split_kind = 'split',
      spell_check = true,
    },
    commit_select_view = {
      kind = 'floating',
    },
    commit_view = {
      kind = 'vsplit',
      verify_commit = vim.fn.executable 'gpg' == 1, -- Can be set to true or false, otherwise we try to find the binary
    },
    log_view = {
      kind = 'floating',
    },
    rebase_editor = {
      kind = 'auto',
    },
    reflog_view = {
      kind = 'floating',
    },
    merge_editor = {
      kind = 'auto',
    },
    preview_buffer = {
      kind = 'floating_console',
    },
    popup = {
      kind = 'split',
    },
    stash = {
      kind = 'floating',
    },
    refs_view = {
      kind = 'floating',
    },
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit kind=floating<cr>', desc = 'Show Neogit UI' },
  },
}
