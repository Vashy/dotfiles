local M = {
  math = {},
}

--- Sanitize: Replace newlines with '+' and strip extra spaces
local function clean_expression(str)
  return str:gsub('\n', '+'):gsub('%s+', ''):gsub('%+$', '')
end

M.math.calculate_register = function()
  local expression = vim.fn.getreg '"'

  expression = clean_expression(expression)

  local success, result = pcall(vim.fn.eval, expression)

  if success then
    print(result)
    vim.notify(expression .. ' = ' .. result, vim.log.levels.INFO)
  else
    vim.notify('Error: Invalid math expression' .. expression, vim.log.levels.ERROR)
  end
end

M.math.calculate_visual = function()
  -- Yank the current visual selection into the "v" register
  -- 'gv' re-selects it, ' "vy ' yanks it into 'v'
  vim.cmd 'normal! "vy'

  local expression = vim.fn.getreg 'v'

  expression = clean_expression(expression)

  local success, result = pcall(vim.fn.eval, expression)

  if success then
    print(result)
    vim.notify(expression .. ' = ' .. result, vim.log.levels.INFO)
  else
    vim.notify('Error: Invalid math expression: ' .. expression, vim.log.levels.ERROR)
  end
end

return M
