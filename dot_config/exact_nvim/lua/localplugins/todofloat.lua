local M = {}

local function center_in(outer, inner)
  return (outer - inner) / 2
end

local function win_config()
  local width = math.min(math.floor(vim.o.columns * 0.8), 64)
  local height = math.floor(vim.o.lines * 0.8)

  return {
    width = width,
    height = height,
    col = center_in(vim.o.columns, width),
    row = center_in(vim.o.lines, height),
    border = 'single',
    relative = 'win',
  }
end

local function open_floating_file(target_file)
  local expanded_path = vim.fn.expand(target_file)

  if vim.fn.filereadable(expanded_path) == 0 then
    local data_file = vim.uv.fs_open(expanded_path, 'w', 438) -- 438 = 666 octal

    if not data_file then
      vim.notify('todo file does not exist or cannot be opened: ' .. expanded_path, vim.log.levels.ERROR)
      return
    end
    local content = '# TODO\n\n- [ ] something'
    vim.uv.fs_write(data_file, content, -1)
    vim.uv.fs_close(data_file)
  end

  local buf = vim.fn.bufnr(expanded_path, true)

  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, expanded_path)
  end

  vim.bo[buf].swapfile = false

  local win = vim.api.nvim_open_win(buf, true, win_config())

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
    noremap = true,
    silent = true,
    callback = function()
      if vim.api.nvim_get_option_value('modified', { buf = buf }) then
        vim.api.nvim_buf_call(buf, function()
          vim.cmd 'write'
          vim.notify('Todo autosaved', vim.log.levels.DEBUG)
        end)
      end
      vim.api.nvim_win_close(0, true)
    end,
  })
end

local function setup_user_commands(opts)
  local target_file = opts.target_file or 'todo.md'
  vim.api.nvim_create_user_command('TdNotes', function()
    open_floating_file(target_file)
  end, {})
end

M.setup = function(opts)
  setup_user_commands(opts)
end

return M
