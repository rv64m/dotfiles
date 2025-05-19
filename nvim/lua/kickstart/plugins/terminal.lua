-- Terminal configuration for multiple positions
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        -- Size can be a number or function which returns a number
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- Hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- The degree by which to darken to terminal color (0-100)
        start_in_insert = true,
        insert_mappings = true, -- Whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'float', -- Default direction: 'vertical' | 'horizontal' | 'window' | 'float'
        close_on_exit = true, -- Close the terminal window when the process exits
        shell = vim.o.shell, -- Change the default shell
        float_opts = {
          border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }

      -- Custom terminal functions
      local Terminal = require('toggleterm.terminal').Terminal

      -- Define different terminal instances
      local float_term = Terminal:new({ direction = 'float' })
      local horizontal_term = Terminal:new({ direction = 'horizontal' })
      local vertical_term = Terminal:new({ direction = 'vertical' })
      local vertical_term_right = Terminal:new({ direction = 'vertical', go_back = false })
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        float_opts = {
          border = 'double',
        },
      })

      -- Function to toggle terminals
      function _G.toggle_float_term()
        float_term:toggle()
      end

      function _G.toggle_horizontal_term()
        horizontal_term:toggle()
      end

      function _G.toggle_vertical_term()
        vertical_term:toggle()
      end

      function _G.toggle_vertical_term_right()
        vertical_term_right:toggle()
      end

      function _G.toggle_lazygit()
        lazygit:toggle()
      end

      -- Set keymappings
      vim.keymap.set('n', '<leader>tf', '<cmd>lua toggle_float_term()<CR>', { desc = '[T]erminal [F]loat' })
      vim.keymap.set('n', '<leader>th', '<cmd>lua toggle_horizontal_term()<CR>', { desc = '[T]erminal [H]orizontal (Bottom)' })
      vim.keymap.set('n', '<leader>tv', '<cmd>lua toggle_vertical_term()<CR>', { desc = '[T]erminal [V]ertical (Left)' })
      vim.keymap.set('n', '<leader>tr', '<cmd>lua toggle_vertical_term_right()<CR>', { desc = '[T]erminal [R]ight' })
      vim.keymap.set('n', '<leader>tg', '<cmd>lua toggle_lazygit()<CR>', { desc = '[T]erminal Lazy[G]it' })

      -- Terminal navigation
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Auto command to set terminal keymaps when entering terminal
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  },
}
