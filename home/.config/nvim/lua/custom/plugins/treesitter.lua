local parsers = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'zig',
  'java',
  'jsonc',
  'groovy',
  'sql',
  'nix',
}

-- `master` is archived and breaks on nvim 0.12; `main` (the rewrite) needs 0.12.
-- `vim` (0.11) and `nvim` (0.12, NVIM_APPNAME=nvim-next) share this config, so pick per version.
-- `master` is pinned explicitly: the repo's default branch is now `main`.
if vim.fn.has 'nvim-0.12' == 0 then
  return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = parsers,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  }
end

-- `main` needs the tree-sitter CLI (>= 0.26.1) to build parsers
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'
    -- `main` has no jsonc parser: nvim 0.12 maps the jsonc filetype to json
    ts.install(vim.tbl_map(function(p)
      return p == 'jsonc' and 'json' or p
    end, parsers))

    local function start(buf, lang)
      if not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      if lang == 'ruby' then
        vim.bo[buf].syntax = 'ON' -- keep regex highlighting alongside treesitter
      else
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        -- auto_install: build parsers nvim-treesitter knows but that aren't installed yet
        if not vim.treesitter.language.add(lang) and vim.tbl_contains(ts.get_available(), lang) then
          ts.install(lang):await(vim.schedule_wrap(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              start(args.buf, lang)
            end
          end))
        else
          start(args.buf, lang)
        end
      end,
    })
  end,
}
