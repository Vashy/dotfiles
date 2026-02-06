return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('minuet').setup {
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 2048,
        -- Virtual Text is better for Java/JDTls to avoid menu "fights"
        virtualtext = {
          enabled = true,
          auto_trigger_ft = { '*' }, -- Enable for all filetypes
          keymap = {
            accept = '<A-y>', -- Alt + y to accept
            accept_line = '<A-l>',
            prev = '<A-[>',
            next = '<A-]>',
            dismiss = '<A-e>',
          },
        },
        provider = 'openai_fim_compatible',
        --provider = 'openai_compatible',
        provider_options = {
          -- openai_fim_compatible = {
          --   -- For Windows users, TERM may not be present in environment variables.
          --   -- Consider using APPDATA instead.
          --   api_key = 'TERM',
          --   name = 'Llama.cpp',
          --   end_point = 'http://localhost:7999/v1/completions',
          --   -- The model is set by the llama-cpp server and cannot be altered
          --   -- post-launch.
          --   model = 'sweep',
          --   optional = {
          --     max_tokens = 64,
          --     top_p = 0.7,
          --   },
          --   -- Llama.cpp does not support the `suffix` option in FIM completion.
          --   -- Therefore, we must disable it and manually populate the special
          --   -- tokens required for FIM completion.
          --   template = {
          --     prompt = function(context_before_cursor, context_after_cursor, _)
          --       return '<|fim_prefix|>' .. context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
          --     end,
          --     suffix = false,
          --   },
          -- },
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Llama.cpp',
            end_point = 'http://localhost:7999/v1/completions',
            -- The model is set by the llama-cpp server and cannot be altered
            -- post-launch.
            model = 'PLACEHOLDER',
            optional = {
              max_tokens = 48,
              top_p = 0.9,
            },
            -- Llama.cpp does not support the `suffix` option in FIM completion.
            -- Therefore, we must disable it and manually populate the special
            -- tokens required for FIM completion.
            template = {
              prompt = function(context_before_cursor, context_after_cursor, _)
                return '<|fim_prefix|>' .. context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
              end,
              suffix = false,
            },
          },
        },
      }
    end,
  },
  -- { 'nvim-lua/plenary.nvim' },
  -- optional, if you are using virtual-text frontend, nvim-cmp is not
  -- required.
  -- { 'hrsh7th/nvim-cmp' },
  -- optional, if you are using virtual-text frontend, blink is not required.
  -- { 'Saghen/blink.cmp' },
}
