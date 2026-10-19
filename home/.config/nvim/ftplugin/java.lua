vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

local jdtls = require 'jdtls'

-- Help JDTLS find the root of your project
local root_markers = { 'pom.xml', 'gradlew', 'mvnw', '.git' }
local root_dir = jdtls.setup.find_root(root_markers)

-- Create a unique workspace folder for each project to avoid cache conflicts
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name
local lombok_path = vim.fn.expand '~/.local/share/lombok.jar'

-- Use the exact same capabilities as the rest of your editor
local capabilities = require('blink.cmp').get_lsp_capabilities()

local config = {
  -- 1. FORCE THE SERVER TO RUN ON JDK 21
  cmd = {
    '/usr/lib/jvm/open-jdk-21/bin/java', -- Path to the MODERN java executable
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,
    -- Point to the Mason-installed jdtls jar and config
    '-jar',
    vim.fn.split(vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'), '\n')[1],
    '-configuration',
    vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_linux',
    '-data',
    workspace_dir,
  },

  root_dir = root_dir,

  -- Standard LSP capabilities from kickstart
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
  capabilities = capabilities,

  -- 2. DEFINE YOUR RUNTIMES
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-1.8',
            path = '/usr/lib/jvm/open-jdk-8',
          },
          {
            name = 'JavaSE-17',
            path = '/usr/lib/jvm/open-jdk-17',
          },
          {
            name = 'JavaSE-21',
            path = '/usr/lib/jvm/open-jdk-21',
            default = true,
          },
        },
      },
    },
  },

  -- This ensures your keymaps (definition, references) from kickstart still work
  -- on_attach = function(client, bufnr)
  -- on_attach = function(client, bufnr)
  --   _G.lsp_mappings { buf = bufnr, data = { client_id = client.id } }
  -- You can also add JDTLS-specific keymaps here
  -- e.g., require('jdtls').extract_variable()
  -- end,
  -- If you have a specific on_attach function in init.lua, you can call it here
  -- Or just let kickstart's LspAttach autocmd handle it.
  -- end,
}

jdtls.start_or_attach(config)
