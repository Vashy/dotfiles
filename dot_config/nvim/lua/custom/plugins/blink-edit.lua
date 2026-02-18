return {
  'BlinkResearchLabs/blink-edit.nvim',
  enabled = false,
  config = function()
    require('blink-edit').setup {
      llm = {
        provider = 'sweep',
        backend = 'openai',
        url = 'http://localhost:7999',
        model = 'sweep',

        temperature = 0.0,
        -- max_tokens = 1024, -- SMALLER: Usually 1-2 lines of code is enough
        timeout_ms = 10000, -- FASTER: Don't wait 5s for a ghost text
      },
      -- context = {
      --   enabled = true,
      --   max_tokens = 1024, -- TIGHTER: Helps the GPU "read" the prompt faster
      --
      --   -- Focus the "AI's attention" on what you are currently typing
      --   same_file = {
      --     enabled = true,
      --     max_lines_before = 15, -- Give it enough logic above
      --     max_lines_after = 5, -- But less logic below (focus on current flow)
      --   },
      -- },
      lsp = {
        enabled = false, -- Keep this ON: It helps the AI know your variables
        max_definitions = 1, -- But keep it minimal for speed
        max_references = 0, -- References aren't usually needed for line completion
      },
      -- normal_mode = {
      --   enabled = true, -- Predict even if you just stopped moving
      -- },
      ui = {
        progress = true, -- Hide "thinking..." for cleaner line completion
      },

      accept_key = '<C-y>', -- Key to accept prediction
      reject_key = '<C-n>', -- Key to reject prediction
    }
  end,
}
